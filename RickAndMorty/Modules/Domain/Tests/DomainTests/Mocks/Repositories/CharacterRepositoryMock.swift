//
//  CharacterRepositoryMock.swift
//  Domain
//
//  Created by Pedro Juan Baeza Gómez on 16/10/25.
//

import Domain
import Factory

public actor CharacterRepositoryMock: CharacterRepository {
    
    var mockError: Error?
    var mockResponse: Any?
    
    public func setMockError(_ error: Error) {
        self.mockError = error
    }
    
    public func setMockResponse(_ response: Any) {
        self.mockResponse = response
    }
    
    public func getCharacters(page: Int) async throws -> ListEntity<CharacterEntity> {
        
        if let error = mockError {
            throw error
        }
        
        if let response = mockResponse as? ListEntity<CharacterEntity> {
            return response
        }
        
        throw RepositoryErrorMock.responseNotSet
    }
    
    public func getCharacter(characterId: String) async throws -> CharacterEntity {
        
        if let error = mockError {
            throw error
        }
        
        if let response = mockResponse as? CharacterEntity {
            return response
        }
        
        throw RepositoryErrorMock.responseNotSet
    }
}
