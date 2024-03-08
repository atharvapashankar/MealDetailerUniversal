//
//  MDUtilities.swift
//  MealDetailer
//
//  Created by Atharva Pashankar on 3/6/24.
//

import Foundation

class MDUtilities {
    
    
}

extension String {
    func contains(find: String) -> Bool{
        return self.range(of: find) != nil
    }
    func containsIgnoringCase(find: String) -> Bool{
        return self.range(of: find, options: .caseInsensitive) != nil
    }
}
