//
//  MDControlCenterManager.swift
//  MealDetailer
//
//  Created by Atharva Pashankar on 3/9/24.
//

import Foundation

class MDControlCenterManager : ObservableObject {
    
    public enum switchType : String, CaseIterable {
        case listSwitch = "List Switch"
        case horizontalCardScrollSwitch = "Horiontal scrolling of Card View"
    }

    @Published var listSwitch : Bool = false
    @Published var horizontalCardScrollSwitch : Bool = false
    
    static let shared = MDControlCenterManager()
    
    private init() { }
    
    func setOrGetFeatureFlagValue(for type : switchType, value : Bool? = nil) -> Bool? {
        switch type {
        case .horizontalCardScrollSwitch :
            if let value = value {
                horizontalCardScrollSwitch = value
            }
            return horizontalCardScrollSwitch
        case .listSwitch :
            if let value = value {
                listSwitch = value
            }
            return listSwitch
        }
    }
}
