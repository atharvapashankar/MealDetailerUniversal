//
//  MDSettingsView.swift
//  MealDetailer
//
//  Created by Atharva Pashankar on 3/8/24.
//

import SwiftUI

struct MDSettingsView: View {
    @StateObject var mdControlCenterManager = MDControlCenterManager.shared
    var body: some View {
        VStack{
            NavigationView{
                Form {
                    // TODO: Try to iterate thru enum this will save bunch of code
//                    ForEach(MDControlCenterManager.switchType.allCases, id: \.rawValue) { type in
//                        MDFeatureFlag(featureFlagType: type, initialValue: MDControlCenterManager.shared.listSwitch)
//                    }
                    
                    MDFeatureFlag(featureFlagType: .listSwitch, initialValue: MDControlCenterManager.shared.listSwitch)
                    MDFeatureFlag(featureFlagType: .horizontalCardScrollSwitch, initialValue: MDControlCenterManager.shared.horizontalCardScrollSwitch)
                    
                }.navigationTitle("Feature Flag")
            }
        }
    }
}

#Preview {
    MDSettingsView()
}

struct MDFeatureFlag: View {
    
    var featureFlagType : MDControlCenterManager.switchType
    @State var initialValue : Bool
    
    var body: some View {
        HStack{
            Toggle(featureFlagType.rawValue, isOn: $initialValue).onChange(of: initialValue) { value in
                MDControlCenterManager.shared.setFeatureFlagValue(for: featureFlagType, value: value)
            }
        }
    }
}
