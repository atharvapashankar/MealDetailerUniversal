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
    enum codingKeys : String {
        case youtube = "strYoutube"
        case strIngredient = "strIngredient"
        case strMeasure = "strMeasure"
        case strMealName = "strMeal"
        case strMealThumb = "strMealThumb"
    }
    var meals : [String:String]?
    var ingredients : [String:String]?
    init(meals: [String : String]) {
        resolveAll(for: meals)
    }
    
    mutating func resolveAll(for meals: [String:String]) {
        
        var mealIngredients : [String : String] = [:]
        var mealMeasure : [String : String] = [:]
        var mealData : [String : String] = [:]
        for (key,val) in meals {
            if key.contains(find: codingKeys.strIngredient.rawValue) {
                mealIngredients[key] = val
            } else if key.contains(find: codingKeys.strMeasure.rawValue) {
                mealMeasure[key] = val
            } else {
                mealData[key] = val
            }
        }
        self.meals = mealData
        ingredients = joinIngredientsAndMeasures(ingredients: mealIngredients, measures: mealMeasure)
    }
    
    func joinIngredientsAndMeasures(ingredients: [String: String], measures: [String: String]) -> [String: String] {
        var resultDictionary: [String: String] = [:]
        for (ingredientKey, ingredientValue) in ingredients {
            
            if let ingredientNumber = ingredientKey.components(separatedBy: CharacterSet.decimalDigits.inverted).compactMap { Int($0) }.first {
                let measureKey = codingKeys.strMeasure.rawValue + "\(ingredientNumber)"
                if let measureValue = measures[measureKey] {
                    resultDictionary[ingredientValue] = measureValue
                }
            }
        }

        return resultDictionary
    }
}

/*
 "idMeal": "53049",
 "strMeal": "Apam balik",
 "strDrinkAlternate": null,
 "strCategory": "Dessert",
 "strArea": "Malaysian",
 "strInstructions": "Mix milk, oil and egg together. Sift flour, baking powder and salt into the mixture. Stir well until all ingredients are combined evenly. Spread some batter onto the pan. Spread a thin layer of batter to the side of the pan. Cover the pan for 30-60 seconds until small air bubbles appear. Add butter, cream corn, crushed peanuts and sugar onto the pancake. Fold the pancake into half once the bottom surface is browned. Cut into wedges and best eaten when it is warm.",
 "strMealThumb": "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg",
 "strTags": null,
 "strYoutube": "https://www.youtube.com/watch?v=6R8ffRRJcrg",
 "strIngredient1": "Milk",
 "strIngredient2": "Oil",
 "strIngredient3": "Eggs",
 "strIngredient4": "Flour",
 "strIngredient5": "Baking Powder",
 "strIngredient6": "Salt",
 "strIngredient7": "Unsalted Butter",
 "strIngredient8": "Sugar",
 "strIngredient9": "Peanut Butter",
 "strIngredient10": "",
 "strIngredient11": "",
 "strIngredient12": "",
 "strIngredient13": "",
 "strIngredient14": "",
 "strIngredient15": "",
 "strIngredient16": "",
 "strIngredient17": "",
 "strIngredient18": "",
 "strIngredient19": "",
 "strIngredient20": "",
 "strMeasure1": "200ml",
 "strMeasure2": "60ml",
 "strMeasure3": "2",
 "strMeasure4": "1600g",
 "strMeasure5": "3 tsp",
 "strMeasure6": "1/2 tsp",
 "strMeasure7": "25g",
 "strMeasure8": "45g",
 "strMeasure9": "3 tbs",
 "strMeasure10": " ",
 "strMeasure11": " ",
 "strMeasure12": " ",
 "strMeasure13": " ",
 "strMeasure14": " ",
 "strMeasure15": " ",
 "strMeasure16": " ",
 "strMeasure17": " ",
 "strMeasure18": " ",
 "strMeasure19": " ",
 "strMeasure20": " ",
 "strSource": "https://www.nyonyacooking.com/recipes/apam-balik~SJ5WuvsDf9WQ",
 "strImageSource": null,
 "strCreativeCommonsConfirmed": null,
 "dateModified": null
 */
