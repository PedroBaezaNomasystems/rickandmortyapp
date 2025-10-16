//
//  Color.swift
//  RickAndMorty
//
//  Created by Pedro Juan Baeza Gómez on 15/10/25.
//

import SwiftUI

struct CustomPalette {
    
    static let error = Color("Error")
    static let neutral = Color("Neutral")
    static let primary = Color("Primary")
    static let secondary = Color("Secondary")
    static let tertiary = Color("Tertiary")
    static let quaternary = Color("Quaternary")
    static let quinary = Color("Quinary")
}

extension Color {
    
    static let customPalette = CustomPalette.self
}
