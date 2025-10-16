//
//  Font.swift
//  RickAndMorty
//
//  Created by Pedro Juan Baeza Gómez on 16/10/25.
//

import SwiftUI

extension Font {
    
    static func openSansLight(size: Theme.FontSize) -> Font {
        
        openSansFont(family: .light, size: size)
    }
    
    static func openSansRegular(size: Theme.FontSize) -> Font {
        
        openSansFont(family: .regular, size: size)
    }
    
    static func openSansBold(size: Theme.FontSize) -> Font {
        
        openSansFont(family: .bold, size: size)
    }
    
    private static func openSansFont(family: Theme.FontFamily, size: Theme.FontSize) -> Font {
        
        Font.custom(family.rawValue, size: size.rawValue)
    }
}
