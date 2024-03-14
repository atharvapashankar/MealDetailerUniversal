//
//  MDMealNetworkTest.swift
//  MealDetailerTests
//
//  Created by Atharva Pashankar on 3/14/24.
//

import XCTest
@testable import MealDetailer

class MDMealNetworkTest: XCTestCase {
    let url = URL(string:"https://themealdb.com/api/json/v1/1/filter.php?c=Dessert")
    
    let wrongUrl = URL(string:"https://themealdb.com/api/json/v1/1/filter.php?c=Desser")
    
    let dataUrl = URL(string:"https://themealdb.com/api/json/v1/1/lookup.php?i=52774")
    
    let dataWrongUrl = URL(string:"https://themealdb.com/api/json/v1/1/lookup.php?i=kjnac")

    
    func testmealListDataFetch() throws {
        let expectation = self.expectation(description: "API fetches the data")
        MDEngine().fetch(for: try XCTUnwrap(url), completion: { result in
            switch result {
            case .success(let data) :
            XCTAssertNotNil(data, "Data not nil")
                expectation.fulfill()
            case .failure(let error) :
            XCTAssertNil(error, "Error is nil")
            }
        })
        waitForExpectations(timeout: 5)
    }
    
    func testmealListDataFetchFail() throws {
        MDEngine().fetch(for: try XCTUnwrap(wrongUrl), completion: { result in
            switch result {
            case .success(let data) :
            XCTAssertNil(data, "Data is nil")
            case .failure(let error) :
            XCTAssertNotNil(error, "Error is not nil")
            }
        })
    }
    
    
    func testmealDetailDataFetch() throws {
        let expectation = self.expectation(description: "API fetches the data")
        MDEngine().fetch(for: try XCTUnwrap(dataUrl), completion: { result in
            switch result {
            case .success(let data) :
            XCTAssertNotNil(data, "Data not nil")
                expectation.fulfill()
            case .failure(let error) :
            XCTAssertNil(error, "Error is nil")
            }
        })
        waitForExpectations(timeout: 5)
    }
    
     func testmealDetailDataFetchFail() throws {
         
        MDEngine().fetch(for: try XCTUnwrap(dataWrongUrl), completion: { result in
            switch result {
            case .success(let data) :
            XCTAssertNotNil(data, "Data is nil")
            case .failure(let error) :
            XCTAssertNil(error, "Error not nil")
           
            }
        })
         
    }
}
