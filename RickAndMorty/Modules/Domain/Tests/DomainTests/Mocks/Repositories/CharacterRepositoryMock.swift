//
//  CharacterRepositoryMock.swift
//  Domain
//
//  Created by Pedro Juan Baeza Gómez on 16/10/25.
//

import Domain
import Factory

public actor CharacterRepositoryMock: CharacterRepository, Sendable {
    
    private var mockError: RepositoryError?
    private var mockCharacterResponse: CharacterEntity?
    private var mockCharacterListResponse: ListEntity<CharacterEntity>?
    
    public func setMockError(_ error: RepositoryError) {
        self.mockError = error
        self.mockCharacterResponse = nil
        self.mockCharacterListResponse = nil
    }
    
    public func setMockResponse(_ response: CharacterEntity) {
        self.mockCharacterResponse = response
        self.mockCharacterListResponse = nil
        self.mockError = nil
    }
    
    public func setMockResponse(_ response: ListEntity<CharacterEntity>) {
        self.mockCharacterListResponse = response
        self.mockCharacterResponse = nil
        self.mockError = nil
    }
    
    public func getCharacters(page: Int) async throws -> ListEntity<CharacterEntity> {
        if let error = mockError {
            throw error
        }
        if let response = mockCharacterListResponse {
            return response
        }
        throw RepositoryErrorMock.responseNotSet
    }
    
    public func getCharacter(characterId: String) async throws -> CharacterEntity {
        if let error = mockError {
            throw error
        }
        if let response = mockCharacterResponse {
            return response
        }
        throw RepositoryErrorMock.responseNotSet
    }
}
