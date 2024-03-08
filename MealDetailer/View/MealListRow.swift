//
//  MealListRow.swift
//  MealDetailer
//
//  Created by Atharva Pashankar on 3/4/24.
//

import SwiftUI

struct MealListRow: View {
    let meal: Meal
    
    var body: some View {
        HStack {
            mealImage
            mealDetails
        }
        .cornerRadius(8)
    }
    
    private var mealImage: some View {
        AsyncImage(url: URL(string: meal.strMealThumb)) { phase in
            switch phase {
            case .success(let image):
                image.resizable().aspectRatio(contentMode: .fill)
            case .failure:
                Image(systemName: "photo")
            case .empty:
                ProgressView()
            @unknown default:
                EmptyView()
            }
        }
        .frame(width: 80, height: 80).cornerRadius(8)
    }
    
    private var mealDetails: some View {
        VStack(alignment: .leading) {
            Text(meal.strMeal)
                .font(.headline)
            HStack {
                Image(systemName: "doc.circle")
                    .foregroundColor(.teal).shadow(radius: 0.2)
                Text(meal.idMeal)
                    .font(.caption)
                    .padding(5)
                    .background(Color.teal.opacity(0.2))
                    .cornerRadius(5).shadow(radius: 0.2)
            }
        }
    }
}

#Preview {
    MealListRow(meal: Meal(strMeal: "akjcnac", strMealThumb: "akjcnac", idMeal: "kajnc"))
}
