//
//  MDMealListRowView.swift
//  MealDetailer
//
//  Created by Atharva Pashankar on 3/4/24.
//

import SwiftUI

struct MDMealListRowView: View {
    
    @ObservedObject var mdScrollView : MDMealDataModel
    
    var body: some View {
        VStack(alignment: .leading) {
            NavigationView {
                List(mdScrollView.mealList, id: \.id) { meal in
                    NavigationLink(destination: MDMealDetailView(mdMealDetailViewModel: MDMealDetailViewModel.init(mealId: meal.idMeal)), label: {
                        MDMealRowCard(meal: meal)
                    })
                    .listRowSeparator(.hidden, edges: .all)
                    .listRowBackground(MDUtilities.gradientUniversalColor .ignoresSafeArea())
                }
                .navigationTitle("Menu")
            }
        }
        .foregroundColor(MDUtilities.universalColor())
        .background(MDUtilities.gradientUniversalColor)
    }
    
}

struct MDMealRowCard : View {
    let meal: Meal
    
    var body: some View {
        HStack {
            MDImageView(imageUrl: meal.strMealThumb, frame: CGSize(width: 80, height: 80), frameAlignment: .center, contentMode: .fill)
                .cornerRadius(8)
            VStack(alignment: .leading) {
                Text(meal.strMeal)
                    .font(.headline)
                    .padding(5)
                
                Label(meal.idMeal, systemImage: "tag")
                    .font(.caption)
                    .padding(5)
            }.background(.clear)
        }
        .background(.clear)
        .foregroundColor(MDUtilities.universalColor())
    }
}

#Preview {
    MDMealListRowView(mdScrollView: MDMealDataModel())
}
