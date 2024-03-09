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
    
    init(mealId : String) {
        requestMealDetails(for: mealId)
    }
    
    func requestMealDetails(for id : String) {
        MDEngine().reqeustDataForMealDetail(for: id, completion: { result in
            switch result {
            case .success(let meal) :
                self.mealDetail = [meal]
                self.isLoaded = true
            case .failure(let error) :
                break;
            }
        })
    }
    
    func getMealName(for type : MDDynamicMealDetailSanitized.codingKeys) -> String? {
        guard let mealsModel = mealDetail.first, let meal = mealsModel.meals else { return nil }
        return meal[type.rawValue]
    }
    
    func getYoutubeLink() -> String? {
        guard let mealsModel = mealDetail.first, let meal = mealsModel.meals else { return nil }
        guard let youtubeLink = meal[MDDynamicMealDetailSanitized.codingKeys.youtube.rawValue] else {return nil}
        let youtubeTrimLink = "https://www.youtube.com/watch?v="
        let trim = "embed/"
        
        return youtubeLink.replacingOccurrences(of: "watch?v=", with: "embed/")
    }
}
