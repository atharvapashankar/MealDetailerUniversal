//
//  MDMealDataModel.swift
//  MealDetailer
//
//  Created by Atharva Pashankar on 3/3/24.
//

import Foundation


class MDMealDataModel : ObservableObject {
    
    @Published var mealList : [Meal] = []
    var isLoaded : Bool = false
    
    init() {
        self.requestData()
    }
    
    func requestData() {
        
        MDEngine().reqeustDataForMealList( completion: { result in
            switch result {
            case .success(let meal) :
                self.mealList = meal
                self.isLoaded = true
            case .failure(let error) :
                NSLog(error.localizedDescription)
                break;
            }
        })
        
    }
}
