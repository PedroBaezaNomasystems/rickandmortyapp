//
//  Mappeable.swift
//  Data
//
//  Created by Pedro Juan Baeza Gómez on 16/10/25.
//

protocol Mappeable {
    associatedtype Entity: Sendable
    func toDomain() -> Entity
}
