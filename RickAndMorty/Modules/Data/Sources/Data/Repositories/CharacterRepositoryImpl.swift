//
//  CharacterRepositoryImpl.swift
//  Data
//
//  Created by Pedro Juan Baeza Gómez on 15/10/25.
//

import Domain
import Factory

public actor CharacterRepositoryImpl: CharacterRepository {
    
    @Injected(\.networkService)
    private var networkService: NetworkService!
    
    public init() {}
    
    public func getCharacter(characterId: String) async throws(RepositoryError) -> CharacterEntity {
        
        do {
            let response: CharacterResponse = try await networkService.get(resource: "character/\(characterId)", bearer: nil)
            return response.toDomain()
            
        } catch let error {
            throw RepositoryError.generic(error.localizedDescription)
        }
    }
}
