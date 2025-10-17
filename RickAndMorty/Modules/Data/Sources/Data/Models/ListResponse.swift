//
//  ListResponse.swift
//  Data
//
//  Created by Pedro Juan Baeza Gómez on 16/10/25.
//

public struct ListResponse<T: Decodable & Sendable>: Decodable, Sendable {
    
    public let info: ListInfoResponse
    public let results: [T]
    
    public init(
        info: ListInfoResponse,
        results: [T]
    ) {
        self.info = info
        self.results = results
    }
}

public struct ListInfoResponse: Decodable, Sendable {
    
    public let count: Int
    public let pages: Int
    public let next: String?
    public let previous: String?
    
    public init(
        count: Int,
        pages: Int,
        next: String?,
        previous: String?
    ) {
        self.count = count
        self.pages = pages
        self.next = next
        self.previous = previous
    }
}
