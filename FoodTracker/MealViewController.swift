//
//  MealViewController.swift
//  FoodTracker
//
//  Created by Addison Francisco on 9/1/17.
//  Copyright © 2017 Addison Francisco. All rights reserved.
//

import UIKit
import os.log

class MealViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
	
	//MARK: Properties
	@IBOutlet weak var nameTextField: UITextField!
	@IBOutlet weak var photoImageView: UIImageView!
	@IBOutlet weak var ratingControl: RatingControl!
	@IBOutlet weak var saveButton: UIBarButtonItem!
	
	// This value is either passed by 'MealTableViewController' in 'prepare(for:sender)'
	// or constructed as part of addin a new meal
	var meal: Meal?
	
	
	//MARK: View Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Handle the text field's user input through delegate callbacks
		nameTextField.delegate = self
		
		// Enable the Save button only if the text field has a valid Meal name
		updateSaveButtonState()
	}
	
	//MARK: UITextFieldDelegate
	func textFieldDidBeginEditing(_ textField: UITextField) {
		saveButton.isEnabled = false
	}
	
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		textField.resignFirstResponder()
		
		return true
	}
	
	func textFieldDidEndEditing(_ textField: UITextField) {
		updateSaveButtonState()
		navigationItem.title = textField.text
	}
	
	//MARK: UIImagePickerControllerDelegate
	func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
		dismiss(animated: true, completion: nil)
	}
	
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
		// The info dictionary may contain multiple representations of the image. You want to use the original.
		guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
			fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
		}
		
		photoImageView.image = selectedImage
		
		dismiss(animated: true, completion: nil)
	}
	
	//MARK: Navigation
	
	// Configure view controller before it's presented
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		super.prepare(for: segue, sender: sender)
		
		// Configure the destination view controller only when the save button is pressed
		guard let button = sender as? UIBarButtonItem, button === saveButton else {
			os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
			return
		}
		
		let name = nameTextField.text ?? ""
		let photo = photoImageView.image
		let rating = ratingControl.rating
		
		// Set the meal to be passed to MealTableViewController after the unwind segue
		meal = Meal(name: name, photo: photo, rating: rating)
	}
	
	//MARK: Actions
	@IBAction func cancel(_ sender: UIBarButtonItem) {
		dismiss(animated: true, completion: nil)
	}
	
	@IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
		nameTextField.resignFirstResponder()
		
		// Image picker controller that allows user to pick photos from photo library
		let imagePickerController = UIImagePickerController()
		
		// Only allow user to pick photos, not take photos using camera
		imagePickerController.sourceType = .photoLibrary
		
		// Let the the viewController (self) know the user picked an image
		imagePickerController.delegate = self
		
		present(imagePickerController, animated: true, completion: nil)
	}
	
	//MARK: Private Methods
	private func updateSaveButtonState() {
		// Disable the save button if the text field is empty
		let text = nameTextField.text ?? ""
		saveButton.isEnabled = !text.isEmpty
	}
}

