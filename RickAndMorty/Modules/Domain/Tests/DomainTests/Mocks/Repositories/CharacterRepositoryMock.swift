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
        self.mockError = nil
        self.mockCharacterResponse = response
        self.mockCharacterListResponse = nil
    }
    
    public func setMockResponse(_ response: ListEntity<CharacterEntity>) {
        self.mockError = nil
        self.mockCharacterResponse = nil
        self.mockCharacterListResponse = response
    }
    
    public func getCharacters(page: Int, search: String) async throws -> ListEntity<CharacterEntity> {
        if let error = mockError {
            throw error
        }
        if let response = mockCharacterListResponse {
            return response
        }
        
        fatalError("CharacterRepositoryMock not configured. Call setMockError or setMockResponse first.")
    }
    
    public func getCharacter(characterId: String) async throws -> CharacterEntity {
        if let error = mockError {
            throw error
        }
        if let response = mockCharacterResponse {
            return response
        }
        
        fatalError("CharacterRepositoryMock not configured. Call setMockError or setMockResponse first.")
    }
}
