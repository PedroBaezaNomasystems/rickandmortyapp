//
//  Color.swift
//  RickAndMorty
//
//  Created by Pedro Juan Baeza Gómez on 15/10/25.
//

import SwiftUI

struct CustomPalette {
    
    static let primary = Color("Primary")
    static let secondary = Color("Secondary")
    static let neutral = Color("Neutral")
    static let error = Color("Error")
}

extension Color {
    
    static let customPalette = CustomPalette.self
}
