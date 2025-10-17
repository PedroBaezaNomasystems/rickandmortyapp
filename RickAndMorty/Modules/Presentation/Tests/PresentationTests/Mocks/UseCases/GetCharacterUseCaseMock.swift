//
//  GetCharacterUseCaseMock.swift
//  Presentation
//
//  Created by Pedro Juan Baeza Gómez on 17/10/25.
//

import Domain

public actor GetCharacterUseCaseMock: GetCharacterUseCase, Sendable {
    
    private var mockError: UseCaseError?
    private var mockResponse: CharacterEntity?
    
    public func setMockError(_ error: UseCaseError) {
        self.mockError = error
        self.mockResponse = nil
    }
    
    public func setMockResponse(_ response: CharacterEntity) {
        self.mockError = nil
        self.mockResponse = response
    }
    
    public func execute(data: String) async -> Result<CharacterEntity, UseCaseError> {
        if let error = mockError {
            return .failure(error)
        }
        if let response = mockResponse {
            return .success(response)
        }
        
        fatalError("GetCharacterUseCaseMock not configured. Call setMockError or setMockResponse first.")
    }
}
