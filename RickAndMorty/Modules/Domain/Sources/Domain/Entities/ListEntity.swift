//
//  ListEntity.swift
//  Domain
//
//  Created by Pedro Juan Baeza Gómez on 16/10/25.
//

public struct ListEntity<T: Sendable>: Sendable {
    
    public let count: Int
    public let pages: Int
    public let next: String?
    public let previous: String?
    public let results: [T]
    
    public init(
        count: Int,
        pages: Int,
        next: String?,
        previous: String?,
        results: [T]
    ) {
        
        self.count = count
        self.pages = pages
        self.next = next
        self.previous = previous
        self.results = results
    }
}
