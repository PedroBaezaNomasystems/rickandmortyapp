//
//  CharacterResponse.swift
//  Data
//
//  Created by Pedro Juan Baeza Gómez on 15/10/25.
//

public struct CharacterResponse: Decodable, Sendable {
    
    public let id: Int
    public let name: String
    public let status: String
    public let species: String
    public let type: String
    public let gender: String
    public let origin: CharacterOriginResponse
    public let location: CharacterLocationResponse
    public let image: String
    
    public init(
        id: Int,
        name: String,
        status: String,
        species: String,
        type: String,
        gender: String,
        origin: CharacterOriginResponse,
        location: CharacterLocationResponse,
        image: String
    ) {
        self.id = id
        self.name = name
        self.status = status
        self.species = species
        self.type = type
        self.gender = gender
        self.origin = origin
        self.location = location
        self.image = image
    }
}

public struct CharacterOriginResponse: Decodable, Sendable {
    
    public let name: String
    public let url: String
    
    public init(name: String, url: String) {
        self.name = name
        self.url = url
    }
}

public struct CharacterLocationResponse: Decodable, Sendable {
    
    public let name: String
    public let url: String
    
    public init(name: String, url: String) {
        self.name = name
        self.url = url
    }
}
