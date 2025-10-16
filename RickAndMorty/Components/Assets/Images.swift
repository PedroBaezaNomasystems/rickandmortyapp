//
//  Images.swift
//  RickAndMorty
//
//  Created by Pedro Juan Baeza Gómez on 16/10/25.
//
import SwiftUI

enum SystemIcon: String {
    
    case search         = "magnifyingglass"
    case photo          = "photo"
    case persons        = "person.2"
    
    var image: Image {
        
        Image(systemName: rawValue)
    }
}
