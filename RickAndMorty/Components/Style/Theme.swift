//
//  Theme.swift
//  RickAndMorty
//
//  Created by Pedro Juan Baeza Gómez on 16/10/25.
//

import SwiftUI

struct Theme {

    enum Spacing: CGFloat {
        
        case small              = 12.0
        case medium             = 18.0
        case large              = 24.0
    }
    
    enum FontSize: CGFloat {
        
        case label              = 12
        case body               = 14
        case title              = 16
        case headline           = 24
    }
    
    enum FontFamily: String {
        
        case light              = "OpenSans-Light"
        case regular            = "OpenSans-Regular"
        case bold               = "OpenSans-Bold"
    }
}
