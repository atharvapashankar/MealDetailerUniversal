//
//  MealDetailerTests.swift
//  MealDetailerTests
//
//  Created by Atharva Pashankar on 2/29/24.
//

import Foundation
import XCTest
@testable import MealDetailer

class MealDetailerTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
            MDMealDataModel().requestData()
        }
    }
    
    func testMealDataModel() throws {
        let expectation = self.expectation(description: "API fetches the data")
        
        MDEngine().reqeustDataForMealList( completion: { result in
            switch result {
            case .success(let meal) :
                XCTAssertNotNil(meal, "Meal Data is not nil")
                expectation.fulfill()
            case .failure(let error) :
                NSLog(error.localizedDescription)
                break;
            }
        })
        
        waitForExpectations(timeout: 5)
    }
    
    func testMealDetailModel() throws {
        
        let expectation = self.expectation(description: "API fetches the data")
        
        MDEngine().reqeustDataForMealDetail(for: "52774", completion: { result in
            switch result {
            case .success(let meal) :
                XCTAssertNotNil(meal, "Meal Data is not nil")
                //try XCTUnwrap(meal)
                let mealData = meal.meals
                let mealIngredients = meal.ingredients
                XCTAssertNotNil(mealData?.first)
                XCTAssertNotNil(mealIngredients?.first)
                
                expectation.fulfill()
            case .failure(let error) :
                NSLog(error.localizedDescription)
                break;
            }
        })
        waitForExpectations(timeout: 10)
    }
    
    func testMealDetailModelFail() throws {
        MDEngine().reqeustDataForMealDetail(for: "kjbas", completion: { result in
            switch result {
            case .success(let meal) :
                XCTAssertNil(meal, "Meal Data is nil")
            case .failure(let error) :
                XCTAssertNotNil(error, "Error is not nil")
                break;
            }
        })
    }
}
