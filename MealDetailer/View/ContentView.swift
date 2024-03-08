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
        NavigationView {
            VStack(alignment: .leading) {
                List(mdScrollView.mealList, id: \.id) { meal in
                    NavigationLink(destination: MealListView(mdMealDetailViewModel: MDMealDetailViewModel.init(mealId: meal.idMeal)), label: {
                        MealListRow(meal: meal)
                    })
                }.navigationTitle("Menu")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(mdScrollView: MDScrollView())
    }
}
