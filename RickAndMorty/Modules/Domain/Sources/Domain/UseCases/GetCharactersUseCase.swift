//
//  GetCharactersUseCase.swift
//  Domain
//
//  Created by Pedro Juan Baeza Gómez on 16/10/25.
//

import Foundation
import Factory

public protocol GetCharactersUseCase: UseCase where

    InputType == Int,
    ResultType == ListEntity<CharacterEntity> {
}

public actor GetCharactersUseCaseImpl: GetCharactersUseCase {
    
    @Injected(\.characterRepository)
    private var repository: CharacterRepository!
    
    public init() {}
    
    public func execute(data: Int) async -> Result<ListEntity<CharacterEntity>, UseCaseError> {
        
        do {
            let characters = try await repository.getCharacters(page: data)
            return .success(characters)
            
        } catch {
            return .failure(.generic)
        }
    }
}
