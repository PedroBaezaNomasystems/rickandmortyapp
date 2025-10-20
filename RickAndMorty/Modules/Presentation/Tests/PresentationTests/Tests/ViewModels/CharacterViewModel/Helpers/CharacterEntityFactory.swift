//
//  CharacterEntityFactory.swift
//  Presentation
//
//  Created by Pedro Juan Baeza Gómez on 17/10/25.
//

import Domain

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
    
    static func makeListTwoPagesEntity() -> ListEntity<CharacterEntity> {
        ListEntity(
            count: 2,
            pages: 2,
            next: nil,
            previous: nil,
            results: [makeCharacterEntity()]
        )
    }
}
