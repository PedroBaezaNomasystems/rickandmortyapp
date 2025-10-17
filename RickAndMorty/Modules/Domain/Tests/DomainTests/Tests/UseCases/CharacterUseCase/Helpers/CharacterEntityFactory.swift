//
//  CharacterEntityFactory.swift
//  Domain
//
//  Created by Pedro Juan Baeza Gómez on 17/10/25.
//

@testable import Domain

final class CharacterEntityFactory {
    
    static func makeCharacterEntity() -> CharacterEntity {
        CharacterEntity(
            id: 0,
            name: "Name",
            status: "Status",
            species: "Species",
            type: "Type",
            gender: "Gender",
            origin: "OriginName",
            location: "LocationName",
            image: "Image"
        )
    }
    
    static func makeListEntity() -> ListEntity<CharacterEntity> {
        ListEntity(
            count: 1,
            pages: 1,
            next: nil,
            previous: nil,
            results: [makeCharacterEntity()]
        )
    }
}
