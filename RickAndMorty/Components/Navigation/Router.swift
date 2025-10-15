//
//  Router.swift
//  RickAndMorty
//
//  Created by Pedro Juan Baeza Gómez on 15/10/25.
//

import Combine
import SwiftUI
import Presentation

final class Router: ObservableObject, Routing {
    
    @Published var navPath = NavigationPath()
    
    func navigate(to destination: Destination) {
        
        navPath.append(destination)
    }
    
    func navigateBack() {
        
        navPath.removeLast()
    }
    
    func navigateToRoot() {
        
        navPath.removeLast(navPath.count)
    }
}
