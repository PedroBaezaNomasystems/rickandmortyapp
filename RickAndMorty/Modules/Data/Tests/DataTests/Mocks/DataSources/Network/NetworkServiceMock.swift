//
//  NetworkErrorMock.swift
//  Data
//
//  Created by Pedro Juan Baeza Gómez on 16/10/25.
//

import Foundation
import Data

public actor NetworkServiceMock: NetworkService {
    
    var mockError: Error?
    var mockResponse: Any?
    
    public func setMockError(_ error: Error) {
        self.mockError = error
    }
    
    public func setMockResponse(_ response: Any) {
        self.mockResponse = response
    }
    
    public func get<T>(resource: String, params: [String : String]?, bearer: String?) async throws -> T where T : Decodable {
        
        if let error = mockError {
            throw error
        }
        
        if let response = mockResponse as? T {
            return response
        }
        
        throw NetworkErrorMock.responseNotSet
    }
    
    public func post<T, U>(resource: String, body: U, bearer: String?) async throws -> T where T : Decodable, U : Encodable {
        
        if let error = mockError {
            throw error
        }
        
        if let response = mockResponse as? T {
            return response
        }
        
        throw NetworkErrorMock.responseNotSet
    }
}
