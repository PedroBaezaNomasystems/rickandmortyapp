//
//  ListResponse.swift
//  Data
//
//  Created by Pedro Juan Baeza Gómez on 16/10/25.
//

struct ListResponse<T: Decodable & Sendable>: Decodable, Sendable {
    
    let info: ListInfoResponse
    let results: [T]
}

struct ListInfoResponse: Decodable, Sendable {
    
    let count: Int
    let pages: Int
    let next: String?
    let previous: String?
}
