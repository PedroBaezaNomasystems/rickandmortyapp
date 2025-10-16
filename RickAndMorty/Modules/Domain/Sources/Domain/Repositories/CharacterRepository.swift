//
//  CharacterRepository.swift
//  Domain
//
//  Created by Pedro Juan Baeza Gómez on 15/10/25.
//

public protocol CharacterRepository: Actor {
    
    func getCharacters(page: Int) async throws -> ListEntity<CharacterEntity>
    func getCharacter(characterId: String) async throws -> CharacterEntity
}
