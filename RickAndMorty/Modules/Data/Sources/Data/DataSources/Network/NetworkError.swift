//
//  NetworkError.swift
//  Data
//
//  Created by Pedro Juan Baeza Gómez on 15/10/25.
//

public enum NetworkError: Error {
    
    case invalidResponse
    case httpError(statusCode: Int, responseBody: String?)
    case decodingError(Error)
}
