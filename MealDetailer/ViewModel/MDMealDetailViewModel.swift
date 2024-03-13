//
//  MDMealDetailViewModel.swift
//  MealDetailer
//
//  Created by Atharva Pashankar on 3/8/24.
//

import Foundation

class MDMealDetailViewModel : ObservableObject {
    
    @Published var mealDetail : [MDDynamicMealDetailSanitized] = []
    @Published var isLoaded : Bool = false
    var mealDetailsPresent : [Int : [MDDynamicMealDetailSanitized.codingKeys:String]] = [:]
    var mealIngredients : [String : String] = [:]
    
    init(mealId : String) {
        requestMealDetails(for: mealId)
    }
    
    func requestMealDetails(for id : String) {
        MDEngine().reqeustDataForMealDetail(for: id, completion: { result in
            switch result {
            case .success(let meal) :
                self.mealDetail = [meal]
                self.isLoaded = true
                if let mealDetailPresent = meal.detailsPresent, let mealIgredients = meal.ingredients {
                    self.mealDetailsPresent = mealDetailPresent
                    self.mealIngredients = mealIgredients
                }
            case .failure(let error) :
                NSLog(error.localizedDescription)
                break;
            }
        })
    }
}
