//
//  MealListView.swift
//  MealDetailer
//
//  Created by Atharva Pashankar on 3/4/24.
//

import SwiftUI
import UIKit
import WebKit

struct MealListView: View {
    @StateObject var mdMealDetailViewModel : MDMealDetailViewModel
    
    var body: some View {
        if mdMealDetailViewModel.isLoaded{
            mealDetails
        } else {
            activityIndicator
        }
    }
    
    private var mealDetails: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(mdMealDetailViewModel.getMealName(for: .strMealName) ?? "ABCDEF")
                .font(.headline).lineLimit(1)
            let tags = "99999"
                HStack {
                    Image(systemName: "tag")
                        .foregroundColor(.green)
                    Text(tags)
                        .font(.caption)
                        .foregroundColor(.gray)
                        .padding(5)
                        .background(Color.yellow.opacity(0.2))
                        .cornerRadius(5)
                }.padding(.leading, 8)
            
            YoutubeVideoView(youtubeVideoID: "asc").frame(width: UIScreen.main.bounds.width, height: 200)
        }
        
    }
    
    private var activityIndicator: some View {
        VStack{
            ProgressView("Loading.....")
        }
    }
}

#Preview {
    MealListView(mdMealDetailViewModel: MDMealDetailViewModel(mealId: "52772"))
}

struct YoutubeVideoView: UIViewRepresentable {
    
    var youtubeVideoID: String
    
    func makeUIView(context: Context) -> WKWebView  {
        
        WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        
        let path = "https://www.youtube.com/embed/4aZr5hZXP_s"
        guard let url = URL(string: path) else { return }
        
        uiView.scrollView.isScrollEnabled = false
        uiView.load(.init(url: url))
    }
}
