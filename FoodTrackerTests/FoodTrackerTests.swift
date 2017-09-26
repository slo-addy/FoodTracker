//
//  FoodTrackerTests.swift
//  FoodTrackerTests
//
//  Created by Addison Francisco on 9/1/17.
//  Copyright © 2017 Addison Francisco. All rights reserved.
//

import XCTest
@testable import FoodTracker

class FoodTrackerTests: XCTestCase {
	
	// MARK: Meal Class Tests
	
	// Confirm that the Meal initializer returns a Meal object when passed valid parameters.
	func testMealInitializationSucceeds() {
		// Zero Rating
		let zeroRatingMeal = Meal.init(name: "Zero", photo: nil, rating: 0)
		XCTAssertNotNil(zeroRatingMeal)
		
		// Highest Positive Rating
		let positiveRatingMeal = Meal.init(name: "Positive", photo: nil, rating: 5)
		XCTAssertNotNil(positiveRatingMeal)
	}
	
	
	// Confirm that the Meal initialier returns nil when passed a negative rating or an empty name.
	func testMealInitializationFails() {
		// Negative Rating
		let negatingRatingMeal = Meal.init(name: "Negative", photo: nil, rating: -1)
		XCTAssertNil(negatingRatingMeal)
		
		// Rating exceeds maximum
		let largeRatingMeal = Meal.init(name: "Large", photo: nil, rating: 6)
		XCTAssertNil(largeRatingMeal)
		
		// Empty String
		let emptyStringMeal = Meal.init(name: "", photo: nil, rating: 0)
		XCTAssertNil(emptyStringMeal)
	}
}
