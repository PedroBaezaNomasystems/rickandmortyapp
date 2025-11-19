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
    
    public func getCharacters(page: Int, search: String) async throws(RepositoryError) -> ListEntity<CharacterEntity> {
        
        do {
            let params: [String: String]? = [
                "page": "\(page)",
                "name": "\(search)"
            ]
            let response: ListResponse<CharacterResponse> = try await networkService.get(resource: "character", params: params, bearer: nil)
            return response.toDomain()
            
        } catch let error {
            throw RepositoryError.generic(error.localizedDescription)
        }
    }
    
    public func getCharacter(characterId: Int) async throws(RepositoryError) -> CharacterEntity {
        
        do {
            let response: CharacterResponse = try await networkService.get(resource: "character/\(characterId)", params: nil, bearer: nil)
            return response.toDomain()
            
        } catch let error {
            throw RepositoryError.generic(error.localizedDescription)
        }
    }
}
