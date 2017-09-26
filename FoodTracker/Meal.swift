//
//  Meal.swift
//  FoodTracker
//
//  Created by Addison Francisco on 9/25/17.
//  Copyright © 2017 Addison Francisco. All rights reserved.
//

import UIKit

class Meal {
	
	// MARK: Properties
	
	var name: String
	var photo: UIImage?
	var rating: Int

	// MARK: Initizialier
	
	init?(name: String, photo: UIImage?, rating: Int) {
		
		// The name must not be empty
		guard !name.isEmpty else {
			return nil
		}
		
		// The rating must be between 0 and 5 inclusively
		guard (rating >= 0) && (rating <= 5) else {
			return nil
		}
		
		self.name = name
		self.photo = photo
		self.rating = rating
	}

}
