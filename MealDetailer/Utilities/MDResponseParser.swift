//
//  MDResponseParser.swift
//  MealDetailer
//
//  Created by Atharva Pashankar on 3/6/24.
//

import Foundation

class MDResponseParser {
    
    func decodeDataForMealList(for data : Data) -> MealsResponse? {
        let decoder = JSONDecoder()
        guard let mealMenuData = try? decoder.decode(MealsResponse.self, from: data) else { return nil}
        return mealMenuData
    }
    func decodeDataForMealDetail(for data : Data) -> MDDynamicMealDetail? {
        
        let decoder = JSONDecoder()
        let mealDetails = try? decoder.decode(MDDynamicMealDetail.self, from: data)
        
        let str = mealDetails?["strMeasure9"]
        let abcd = mealDetails?.meals
        let abcde = abcd?.first
        
        return mealDetails
    }
    
    func sanitizeResponse(for mealDetail: MDDynamicMealDetail) -> MDDynamicMealDetailSanitized? {
        
        guard let meals = mealDetail.meals.first else {
            return nil
        }
        var santizedMeal : [String:String] = [:]
        for (key,optionalVal) in meals {
            if let val = optionalVal, !val.isEmpty, val != " " {
                santizedMeal[key] = val
            }
        }
        return MDDynamicMealDetailSanitized(meals: santizedMeal)
    }
    
}
