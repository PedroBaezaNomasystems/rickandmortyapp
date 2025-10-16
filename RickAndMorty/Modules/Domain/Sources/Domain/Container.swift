//
//  Container.swift
//  Domain
//
//  Created by Pedro Juan Baeza Gómez on 15/10/25.
//

import Foundation
import Factory

extension Container {
    
    public var characterRepository: Factory<CharacterRepository?> {
        promised()
    }
}

extension Container {
    
    public var getCharactersUseCase: Factory<(any GetCharactersUseCase)?> {
        promised()
    }
    
    public var getCharacterUseCase: Factory<(any GetCharacterUseCase)?> {
        promised()
    }
}
