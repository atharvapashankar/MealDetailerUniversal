//
//  MDHomeView.swift
//  MealDetailer
//
//  Created by Atharva Pashankar on 3/8/24.
//

import SwiftUI

struct MDHomeView: View {
    @ObservedObject var mdScrollView : MDScrollView
    @StateObject var mdControlCenterManager = MDControlCenterManager.shared
    var body: some View {
        if mdControlCenterManager.listSwitch {
            MDMealListRowView(mdScrollView: mdScrollView)
        } else {
            MDMealListCardView(mdScrollView: mdScrollView)
        }
    }
}

#Preview {
    MDHomeView(mdScrollView: MDScrollView())
}
