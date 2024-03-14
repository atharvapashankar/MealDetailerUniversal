//
//  ContentView.swift
//  MealDetailer
//
//  Created by Atharva Pashankar on 2/29/24.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var mdScrollView : MDMealDataModel
    @State private var isShowingDetailView = false
    
    var body: some View {
        
        TabView {
            MDHomeView(mdScrollView: mdScrollView)
                .tabItem { Label(
                    title: { Text("Deserts") },
                    icon: { Image(systemName: "staroflife") }
                ) }
            
            MDSettingsView()
                .tabItem { Label(
                    title: { Text("Settings") },
                    icon: { Image(systemName: "slider.horizontal.3") }
                ) }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(mdScrollView: MDMealDataModel())
    }
}
