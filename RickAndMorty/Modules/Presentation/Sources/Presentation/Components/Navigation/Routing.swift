//
//  Routing.swift
//  Presentation
//
//  Created by Pedro Juan Baeza Gómez on 15/10/25.
//

import SwiftUI

public protocol Routing {
    
    func navigate(to route: Destination)
    func navigateBack()
    func navigateToRoot()
}
