//
//  MDDesertModel.swift
//  MealDetailer
//
//  Created by Atharva Pashankar on 3/1/24.
//

import Foundation

struct MealsResponse: Codable {
    let meals: [Meal]
}

struct Meal: Codable, Identifiable {
    var id: String { idMeal }
    let strMeal: String
    let strMealThumb: String
    let idMeal: String
}

struct MDDynamicMealDetail : Codable {
    let meals: [[String: String?]]
    
    subscript(key: String) -> String? {
        guard let meal = self.meals.first, let optionalValue = meal[key], let value = optionalValue else { return nil }
        return value
    }
}

struct MDDynamicMealDetailSanitized {
    enum codingKeys : String, CaseIterable, Identifiable {
        var id: String { self.rawValue }
        
        case MealThumb = "strMealThumb"
        case MealName = "strMeal"
        case DrinkAlternate = "strDrinkAlternate"
        case Category = "strCategory"
        case Area = "strArea"
        case Tags = "strTags"
        
        case Instructions = "strInstructions"
        case Ingredient = "strIngredient"
        case Measure = "strMeasure"
        case Youtube = "strYoutube"
        
        case Source = "strSource"
        case ImageSource = "strImageSource"
        case CreativeCommonsConfirmed = "strCreativeCommonsConfirmed"
        case dateModified = "dateModified"
        case unknown
    }
    
    
    var meals : [String:String]?
    var ingredients : [String:String]?
    var detailsPresent : [Int : [codingKeys:String]]?
    
    init(meals: [String : String]) {
        resolveAll(for: meals)
    }
    
    mutating func resolveAll(for meals: [String:String]) {
        
        var mealIngredients : [String : String] = [:]
        var mealMeasure : [String : String] = [:]
        var mealData : [String : String] = [:]
        for (key,val) in meals {
            if key.contains(find: codingKeys.Ingredient.rawValue) {
                mealIngredients[key] = val
            } else if key.contains(find: codingKeys.Measure.rawValue) {
                mealMeasure[key] = val
            } else {
                mealData[key] = val
            }
        }
        
        self.detailsPresent = createKeysForViews(for: mealData)
        self.meals = mealData
        ingredients = joinIngredientsAndMeasures(ingredients: mealIngredients, measures: mealMeasure)
    }
    
    func joinIngredientsAndMeasures(ingredients: [String: String], measures: [String: String]) -> [String: String] {
        var resultDictionary: [String: String] = [:]
        for (ingredientKey, ingredientValue) in ingredients {
            
            if let ingredientNumber = ingredientKey.components(separatedBy: CharacterSet.decimalDigits.inverted).compactMap({ Int($0) }).first {
                let measureKey = codingKeys.Measure.rawValue + "\(ingredientNumber)"
                if let measureValue = measures[measureKey] {
                    resultDictionary[ingredientValue] = measureValue
                }
            }
        }

        return resultDictionary
    }
    
    func createKeysForViews(for meals : [String: String]) -> [Int : [codingKeys:String]] {
        
        var codingKeyArray : [Int : [codingKeys:String]] = [:]
        var incrementer : Int = 0
        for key in codingKeys.allCases {
            if let value = meals[key.rawValue] {
                codingKeyArray[incrementer] = [key:value]
                incrementer += 1
            }
        }
        
        return codingKeyArray
    }
}
