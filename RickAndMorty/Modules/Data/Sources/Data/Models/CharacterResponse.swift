//
//  CharacterResponse.swift
//  Data
//
//  Created by Pedro Juan Baeza Gómez on 15/10/25.
//

struct CharacterResponse: Decodable {
    
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin: CharacterOriginResponse
    let location: CharacterLocationResponse
    let image: String
}

struct CharacterOriginResponse: Decodable {
    
    let name: String
    let url: String
}

struct CharacterLocationResponse: Decodable {
    
    let name: String
    let url: String
}
