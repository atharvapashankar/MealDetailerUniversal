//
//  MDScrollView.swift
//  MealDetailer
//
//  Created by Atharva Pashankar on 3/3/24.
//

import Foundation



class MDScrollView : ObservableObject {
    
    @Published var mealList : [Meal] = []
    
    init() {
        self.requestData()
    }
    
    func requestData() {
        
        MDEngine().reqeustDataForMealList( completion: { result in
            switch result {
            case .success(let meal) :
                self.mealList = meal
            case .failure(let error) :
                NSLog(error.localizedDescription)
                break;
            }
        })
        
    }
}
