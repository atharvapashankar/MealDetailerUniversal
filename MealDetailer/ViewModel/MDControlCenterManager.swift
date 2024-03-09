//
//  MDControlCenterManager.swift
//  MealDetailer
//
//  Created by Atharva Pashankar on 3/9/24.
//

import Foundation

class MDControlCenterManager : ObservableObject {
    
    public enum switchType : String, CaseIterable {
        case navigationSwitch = "Navigation Switch"
        case listSwitch = "List Switch"
        case horizontalCardScrollSwitch = "Horiontal scrolling of Card View"
    }
    
    @Published var navigationSwitch : Bool = false
    @Published var listSwitch : Bool = false
    @Published var horizontalCardScrollSwitch : Bool = false
    
    static let shared = MDControlCenterManager()
    
    private init() { }
    
    func setFeatureFlagValue(for type : switchType, value : Bool) {
        switch type {
        case .horizontalCardScrollSwitch :
            horizontalCardScrollSwitch = value
            return
        case .listSwitch :
            listSwitch = value
            return
        case .navigationSwitch :
            navigationSwitch = value
            return
        }
    }
}
