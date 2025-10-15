//
//  GetCharacterUseCase.swift
//  Domain
//
//  Created by Pedro Juan Baeza Gómez on 15/10/25.
//

import Foundation
import Factory

public protocol GetCharacterUseCase: UseCase where

    InputType == String,
    ResultType == CharacterEntity {
}

public actor GetCharacterUseCaseImpl: GetCharacterUseCase {
    
    @Injected(\.characterRepository)
    private var repository: CharacterRepository!
    
    public init() {}
    
    public func execute(data: String) async -> Result<CharacterEntity, UseCaseError> {
        
        do {
            let character = try await repository.getCharacter(characterId: data)
            return .success(character)
            
        } catch {
            return .failure(.generic)
        }
    }
}
