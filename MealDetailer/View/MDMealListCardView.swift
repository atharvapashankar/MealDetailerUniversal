//
//  MDMealCardView.swift
//  MealDetailer
//
//  Created by Atharva Pashankar on 3/9/24.
//

import SwiftUI

struct MDMealListCardView: View {
    
    @ObservedObject var mdScrollView : MDScrollView
    @StateObject var mdControlCenterManager = MDControlCenterManager.shared
    
    var body: some View {
        VStack {
            NavigationView{
                
                if mdControlCenterManager.horizontalCardScrollSwitch {
                    ScrollView(.horizontal) {
                        LazyHGrid(rows: [GridItem(.adaptive(minimum: 200), spacing: 20)], spacing: 20) {
                            ForEach(mdScrollView.mealList) { meal in
                                NavigationLink(destination: MealListView(mdMealDetailViewModel: MDMealDetailViewModel.init(mealId: meal.idMeal)), label: {
                                    MDMealCard(meal: meal)
                                })
                            }
                            
                        }
                    }.navigationTitle("Menu")
                } else {
                    ScrollView {
                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 160), spacing: 2)], spacing: 15) {
                            ForEach(mdScrollView.mealList) { meal in
                                NavigationLink(destination: MealListView(mdMealDetailViewModel: MDMealDetailViewModel.init(mealId: meal.idMeal)), label: {
                                    MDMealCard(meal: meal)
                                })
                            }
                        }
                        .padding(.top)
                    }.navigationTitle("Menu")
                }
            }
        }
    }
}

#Preview {
    MDMealListCardView(mdScrollView: MDScrollView())
}

struct MDMealCard: View {
    let meal : Meal
    var body: some View {
        VStack{
            AsyncImage(url: URL(string: meal.strMealThumb)) { image in
                image.image?
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .overlay(alignment: .bottom){
                        Text(meal.strMeal)
                            .font(.headline)
                            .foregroundStyle(.white)
                            .frame(maxWidth: 136)
                            .shadow(color: .black, radius: 3)
                            .padding()
                    }
            }
            .frame(width: 160, height: 217, alignment: .top)
            .clipShape(RoundedRectangle(cornerSize: CGSize(width: 20, height: 10)))
            .shadow(color: .black, radius: 10)
        }
    }
}
