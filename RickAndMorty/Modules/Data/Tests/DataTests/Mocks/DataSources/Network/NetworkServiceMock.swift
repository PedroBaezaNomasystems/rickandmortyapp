//
//  NetworkErrorMock.swift
//  Data
//
//  Created by Pedro Juan Baeza Gómez on 16/10/25.
//

import Data

public actor NetworkServiceMock: NetworkService, Sendable {
    
    private var mockError: NetworkError?
    private var mockGetResponse: Any?
    private var mockPostResponse: Any?
    
    public func setMockError(_ error: NetworkError) {
        self.mockError = error
        self.mockGetResponse = nil
        self.mockPostResponse = nil
    }
    
    public func setMockGetResponse(_ response: Any) {
        self.mockError = nil
        self.mockGetResponse = response
        self.mockPostResponse = nil
    }
    
    public func setMockPostResponse(_ response: Any) {
        self.mockError = nil
        self.mockGetResponse = nil
        self.mockPostResponse = response
    }
    
    public func get<T>(resource: String, params: [String : String]?, bearer: String?) async throws -> T where T : Decodable {
        if let error = mockError {
            throw error
        }
        if let response = mockGetResponse as? T {
            return response
        }
        
        fatalError("NetworkServiceMock not configured. Call setMockError, setMockGetResponse or setMockPostResponse first.")
    }
    
    public func post<T, U>(resource: String, body: U, bearer: String?) async throws -> T where T : Decodable, U : Encodable {
        if let error = mockError {
            throw error
        }
        if let response = mockPostResponse as? T {
            return response
        }
        
        fatalError("NetworkServiceMock not configured. Call setMockError, setMockGetResponse or setMockPostResponse first.")
    }
}
