//
//  MDUtilities.swift
//  MealDetailer
//
//  Created by Atharva Pashankar on 3/6/24.
//

import Foundation
import SwiftUI

class MDUtilities {
    
    struct Constants {
        static let youtubeWatchLink = "watch?v="
        static let youtubeEmbedLink = "embed/"
        static let youtubeVideoLabel = "Youtube Video"
    }
    
    static let gradientUniversalColor = gradientUniversalColor()
        
    static func gradientUniversalColor(startPoint : UnitPoint? = nil, endPoint : UnitPoint? = nil) -> LinearGradient {
        return LinearGradient(gradient: Gradient(colors: [Color("customGradientColor", bundle: Bundle.main), Color("customGradientColor1", bundle: Bundle.main)]), startPoint: startPoint ?? .bottomLeading, endPoint: endPoint ?? .topTrailing)
    }
    
    
    static func universalColor() -> Color {
        return Color("fontColor", bundle: Bundle.main)
    }
}

extension String {
    func contains(find: String) -> Bool{
        return self.range(of: find) != nil
    }
    func containsIgnoringCase(find: String) -> Bool{
        return self.range(of: find, options: .caseInsensitive) != nil
    }
}


