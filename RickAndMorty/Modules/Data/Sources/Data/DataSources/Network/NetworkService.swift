//
//  NetworkService.swift
//  Data
//
//  Created by Pedro Juan Baeza Gómez on 15/10/25.
//

import Foundation

public protocol NetworkService: Actor {
    
    func get<T: Decodable>(resource: String, bearer: String?) async throws -> T
    func post<T: Decodable, U: Encodable>(resource: String, body: U, bearer: String?) async throws -> T
}

public actor NetworkServiceImpl: NetworkService {
    
    private let baseUrl: URL
    
    public init(baseUrl: URL) {
        
        self.baseUrl = baseUrl
    }
    
    public func get<T: Decodable>(resource: String, bearer: String?) async throws -> T {
        
        let url = baseUrl.appendingPathComponent(resource)
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        if let token = bearer {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        debugPrint("GET Request: \(url.absoluteString)")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        try validateResponse(response, data: data)
        
        return try decodeResponse(data)
    }
    
    public func post<T: Decodable, U: Encodable>(resource: String,
                                                 body: U,
                                                 bearer: String?) async throws -> T {
        
        let url = baseUrl.appendingPathComponent(resource)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONEncoder().encode(body)
        
        if let token = bearer {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        debugPrint("POST Request: \(url.absoluteString)")
        debugPrint("POST Body: \(String(data: request.httpBody ?? Data(), encoding: .utf8) ?? "nil")")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        try validateResponse(response, data: data)
        
        return try decodeResponse(data)
    }
    
    private func validateResponse(_ response: URLResponse, data: Data) throws {
        
        guard let httpResponse = response as? HTTPURLResponse else {
            debugPrint("Invalid response received")
            throw NetworkError.invalidResponse
        }
        debugPrint("Response Status Code: \(httpResponse.statusCode)")
        
        guard (200...299).contains(httpResponse.statusCode) else {
            let responseBody = String(data: data, encoding: .utf8) ?? "nil"
            debugPrint("HTTP Error: \(httpResponse.statusCode)")
            debugPrint("Response Body: \(responseBody)")
            throw NetworkError.httpError(statusCode: httpResponse.statusCode, responseBody: responseBody)
        }
    }
    
    private func decodeResponse<T: Decodable>(_ data: Data) throws -> T {
        
        do {
            let decoded = try JSONDecoder().decode(T.self, from: data)
            debugPrint("Decoded Response: \(decoded)")
            return decoded
        } catch {
            debugPrint("Decoding Error: \(error)")
            throw NetworkError.decodingError(error)
        }
    }
}
