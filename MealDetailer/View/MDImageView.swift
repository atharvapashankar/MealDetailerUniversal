//
//  MDImageView.swift
//  MealDetailer
//
//  Created by Atharva Pashankar on 3/10/24.
//

import SwiftUI

struct MDImageView : View {
    var imageUrl : String
    
    var frame : CGSize
    var frameAlignment : Alignment
    var shadowColor : Color?
    var shadowRadius : CGFloat?
    var contentMode : ContentMode
    
    var body: some View {
        if let imageUrl = URL(string: imageUrl) {
            AsyncImage(url: imageUrl) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: contentMode)
                    .frame(width: frame.width, height: frame.height, alignment: .top)
            } placeholder: {
                Image(systemName: "photo")
                    .resizable()
                    .aspectRatio(contentMode: contentMode)
                    .frame(width: frame.width, height: frame.height, alignment: .top)
            }
        } else {
            Image(systemName: "photo")
                .resizable()
                .aspectRatio(contentMode: contentMode)
                .frame(width: frame.width, height: frame.height, alignment: .top)
        }
        
    }
}
