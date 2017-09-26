//
//  MealViewController.swift
//  FoodTracker
//
//  Created by Addison Francisco on 9/1/17.
//  Copyright © 2017 Addison Francisco. All rights reserved.
//

import UIKit

class MealViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
	
	// MARK: Properties
	@IBOutlet weak var nameTextField: UITextField!
	@IBOutlet weak var photoImageView: UIImageView!
	@IBOutlet weak var ratingControl: RatingControl!
	
	// MARK: View Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
		
		nameTextField.delegate = self
	}
	
	// MARK: UITextFieldDelegate
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		textField.resignFirstResponder()
		
		return true
	}
	
	func textFieldDidEndEditing(_ textField: UITextField) {
		textField.text = nil
	}
	
	// MARK: UIImagePickerControllerDelegate
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
	
	// MARK: Actions
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
	

}

