//
//  MealListView.swift
//  MealDetailer
//
//  Created by Atharva Pashankar on 3/4/24.
//

import SwiftUI
import UIKit
import WebKit

struct MDMealDetailView: View {
    @StateObject var mdMealDetailViewModel : MDMealDetailViewModel
    
    var body: some View {
        VStack {
            if mdMealDetailViewModel.isLoaded {
                ScrollView {
                    mealDetails
                }
            } else {
                activityIndicator
                    .frame(width: 500,height: 500,alignment: .center)
            }
        }
        .ignoresSafeArea(.container, edges: .top)
        .background(
            MDUtilities.gradientUniversalColor)
    }
    
    private var mealDetails: some View {
        VStack(alignment: .leading) {
            ForEach(mdMealDetailViewModel.mealDetailsPresent.sorted(by: { $0.key < $1.key }), id: \.key) { key, value in
                
                if let data = value.first {
                    MDDetailDataView(mdMealDetailViewModel: mdMealDetailViewModel, key: data.key, value: data.value)
                }
            }
        }
    }
    
    
    private var activityIndicator: some View {
        VStack{
            ProgressView("Loading.....")
        }
    }
}

struct MDDetailDataView : View {
    
    @StateObject var mdMealDetailViewModel : MDMealDetailViewModel
    var key : MDDynamicMealDetailSanitized.codingKeys
    var value : String
    
    var body: some View {
        switch key {
        case .MealName:
            textDescriptionDetailView(value: value, font: .largeTitle, alignment: .center)
        case .DrinkAlternate:
            textDescriptionDetailView(value: value, font: .caption, alignment: .center, imageName: "circle.grid.cross.fill")
        case .Category:
            textDescriptionDetailView(value: value, font: .caption, alignment: .center, imageName: "circle.grid.cross.fill")
        case .Area:
            textDescriptionDetailView(value: value, font: .caption, alignment: .center, imageName: "mappin.and.ellipse")
        case .Instructions:
            instructionView(for: value)
            ingredientsView()
        case .MealThumb:
            MDImageView(imageUrl: value, frame: CGSize(width: UIScreen.main.bounds.width, height: 400), frameAlignment: .top, contentMode: .fill)
                .clipShape(RoundedRectangle(cornerSize: CGSize(width: 20, height: 10)))
        case .Tags:
            textDescriptionDetailView(value: value, font: .caption, alignment: .center, imageName: "tag")
        case .Youtube:
            MDDetailYoutubeVideoView(youtubeUrl: value)
        case .Ingredient, .Measure:
            EmptyView()
        case .Source, .ImageSource, .CreativeCommonsConfirmed, .dateModified, .unknown:
            textDescriptionDetailView(value: value, font: .caption, alignment: .center, imageName: "circle.grid.cross.fill")
        }
        Spacer()
    }
    
    @ViewBuilder
    private func instructionView(for value: String) -> some View {
        VStack {
            HStack{
                Text("Instructions")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(MDUtilities.universalColor())
            }
            .frame(alignment: .center)
            Text(value)
                .font(.body)
                .foregroundColor(MDUtilities.universalColor())
                .padding()
        }
        //.shadow(color: .secondary, radius: 12)
        .background(.clear)
        .cornerRadius(12)
        //.border(MDUtilities.universalColor(), width: 1)
        .padding([.horizontal, .vertical, .top, .bottom], 10)
    }
    
    private func ingredientsView() -> some View {
        VStack{
            HStack{
                Text("Ingredients")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(MDUtilities.universalColor())
            }.frame(alignment: .center)
            
            ScrollView(.horizontal, showsIndicators : true) {
                LazyHGrid(rows: [GridItem(.adaptive(minimum: 100), spacing: 40), GridItem(.adaptive(minimum: 100), spacing: 40), GridItem(.adaptive(minimum: 100), spacing: 40)], spacing: 50) {
                        
                            ForEach(mdMealDetailViewModel.mealIngredients.sorted(by: { $0.key < $1.key }), id: \.key) { key, value in
                                VStack {
                                    let ingredient = key
                                    if let imageName = ingredient.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
                                        let imageUrl =  "https://www.themealdb.com/images/ingredients/\(imageName)-Small.png"
                                         MDImageView(imageUrl: imageUrl, frame: CGSize(width: 60, height: 50), frameAlignment: .center, contentMode: .fit)
                                             .clipped()
                                    }
                                       
                                    VStack{
                                        Text(key)
                                            .font(.subheadline)
                                            .lineLimit(1)
                                        Text(value)
                                            .font(.caption)
                                            .cornerRadius(2)
                                            .shadow(radius: 0.2)
                                            .textInputAutocapitalization(.words)
                                    }
                                    .frame(width: 100, height: 40)
                                    .background(.clear)
                                }.background(.clear)
                            }
                        }
                        .padding([.leading, .trailing, .top, .bottom], 10)
                }
        }.background(.clear)
            //.border(MDUtilities.universalColor(), width: 1)
            .padding([.horizontal, .vertical, .top, .bottom], 10)
            .foregroundColor(MDUtilities.universalColor())
    }
}


struct MDDetailYoutubeVideoView : View {
    
    @State var isYoutubeVideoHidden : Bool = false
    @State var imageNameForHiddenYoutubeVideo : String = "eye.fill"
    @State var youtubeUrl : String
    
    var body: some View {
        VStack{
            HStack{
                Label(
                    title: { Text(MDUtilities.Constants.youtubeVideoLabel) },
                    icon: { Image(systemName: "play.tv.fill") }
                )
                Button("", systemImage: imageNameForHiddenYoutubeVideo, action: {
                    isYoutubeVideoHidden = !isYoutubeVideoHidden
                    imageNameForHiddenYoutubeVideo = isYoutubeVideoHidden ? "eye.slash.fill" : "eye.fill"
                })
            }
            .frame(alignment: .center)
            .padding([.horizontal, .vertical, .top], 10)
            if !isYoutubeVideoHidden {
                VStack{
                    YoutubeVideoView(url: youtubeUrl).frame(width: UIScreen.main.bounds.width - 40, height: 200)
                }
                .padding([.horizontal, .vertical, .bottom], 10)
            }
        }
        .animation(.snappy, value: 100)
        .border(MDUtilities.universalColor(), width: 1)
        .padding([.horizontal, .vertical, .top, .bottom], 10)
        .foregroundColor(MDUtilities.universalColor())
    }
}

struct MDDetailThumbnailView : View {
    
    var mealThumbnailImage : String
    
    var body: some View {
        MDImageView(imageUrl: mealThumbnailImage, frame: CGSize(width: UIScreen.main.bounds.width, height: 400), frameAlignment: .top, contentMode: .fill)
            .clipShape(RoundedRectangle(cornerSize: CGSize(width: 20, height: 10)))
    }
}

struct YoutubeVideoView: UIViewRepresentable {
    
    var url: String
    
    func makeUIView(context: Context) -> WKWebView  {
        
        WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        let youtubeUrl = url.replacingOccurrences(of: MDUtilities.Constants.youtubeWatchLink, with: MDUtilities.Constants.youtubeEmbedLink)
        guard let url = URL(string: youtubeUrl) else { return }
        
        // TODO: Add Navigation delegate to start or stop Youtube video view in that box instead of full screen view.
        // wkNavigationDelegate
        
        uiView.scrollView.isScrollEnabled = false
        uiView.load(.init(url: url))
    }
}

struct textDescriptionDetailView : View {
    
    var value : String
    var font : Font
    var alignment : TextAlignment
    var imageName : String?
    
    var body: some View {
        HStack {
            if let imageName = imageName {
                Image(systemName: imageName)
                    .foregroundColor(MDUtilities.universalColor())
            }
            Text(value)
                .font(font)
                .multilineTextAlignment(alignment)
                .scaledToFill()
                .foregroundColor(MDUtilities.universalColor())
        }.padding([.leading, .trailing], 4)
    }
}

#Preview {
    MDMealDetailView(mdMealDetailViewModel: MDMealDetailViewModel(mealId: "52774"))
}
