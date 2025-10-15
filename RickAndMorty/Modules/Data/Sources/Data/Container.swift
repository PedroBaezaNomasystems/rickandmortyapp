//
//  Container.swift
//  Data
//
//  Created by Pedro Juan Baeza Gómez on 15/10/25.
//

import Foundation
import Factory

extension Container {
    
    public var networkService: Factory<NetworkService?> { promised() }
}
