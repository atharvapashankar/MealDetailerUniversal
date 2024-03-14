//
//  MDMealCardView.swift
//  MealDetailer
//
//  Created by Atharva Pashankar on 3/9/24.
//

import SwiftUI

struct MDMealListCardView: View {
    
    @ObservedObject var mdScrollView : MDMealDataModel
    @StateObject var mdControlCenterManager = MDControlCenterManager.shared
    
    var body: some View {
        VStack {
            NavigationView{
                if mdControlCenterManager.horizontalCardScrollSwitch {
                    ScrollView(.horizontal) {
                        LazyHGrid(rows: [GridItem(.adaptive(minimum: 200), spacing: 20)], spacing: 20) {
                            ForEach(mdScrollView.mealList) { meal in
                                NavigationLink(destination: MDMealDetailView(mdMealDetailViewModel: MDMealDetailViewModel.init(mealId: meal.idMeal)), label: {
                                    MDMealCard(meal: meal)
                                })
                            }
                        }.padding([.top, .bottom])
                    }.navigationTitle("Menu")
                        .background(
                            MDUtilities.gradientUniversalColor)
                } else {
                    ScrollView {
                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 160), spacing: 2)], spacing: 15) {
                            ForEach(mdScrollView.mealList) { meal in
                                NavigationLink(destination: MDMealDetailView(mdMealDetailViewModel: MDMealDetailViewModel.init(mealId: meal.idMeal)), label: {
                                    MDMealCard(meal: meal)
                                })
                            }
                        }
                        .padding(.top)
                    }
                    .navigationTitle("Menu")
                    .background(MDUtilities.gradientUniversalColor)
                }
            }
        }
    }
}

#Preview {
    MDMealListCardView(mdScrollView: MDMealDataModel())
}

struct MDMealCard: View {
    let meal : Meal
    var body: some View {
        VStack{
            MDImageView(imageUrl: meal.strMealThumb, frame: CGSize(width: 160, height: 217), frameAlignment: .top, contentMode: .fill)
                .overlay(alignment: .bottom) {
                    Text(meal.strMeal)
                        .font(.headline)
                        .foregroundStyle(.white)
                        .frame(maxWidth: 136)
                        .shadow(color: .black, radius: 3)
                        .padding()
                }
                .frame(width: 160, height: 217, alignment: .top)
                .clipShape(RoundedRectangle(cornerSize: CGSize(width: 20, height: 10)))
                .shadow(color: .black, radius: 10)
        }
    }
}
