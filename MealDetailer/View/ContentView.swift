//
//  ContentView.swift
//  MealDetailer
//
//  Created by Atharva Pashankar on 2/29/24.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var mdScrollView : MDScrollView
    @State private var isShowingDetailView = false
    
    var body: some View {
        
        TabView {
            MDHomeView(mdScrollView: mdScrollView)
                .tabItem { Label(
                    title: { Text("Deserts") },
                    icon: { /*@START_MENU_TOKEN@*/Image(systemName: "42.circle")/*@END_MENU_TOKEN@*/ }
                ) }
            
            MDSettingsView()
                .tabItem { Label(
                    title: { Text("Settings") },
                    icon: { /*@START_MENU_TOKEN@*/Image(systemName: "42.circle")/*@END_MENU_TOKEN@*/ }
                ) }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(mdScrollView: MDScrollView())
    }
}
