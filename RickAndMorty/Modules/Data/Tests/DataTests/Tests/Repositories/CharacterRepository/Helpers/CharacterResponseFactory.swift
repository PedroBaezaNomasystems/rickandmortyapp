//
//  CharacterMother.swift
//  Data
//
//  Created by Pedro Juan Baeza Gómez on 17/10/25.
//

import Data

final class CharacterResponseFactory {
    
    static func makeCharacterResponse() -> CharacterResponse {
        CharacterResponse(
            id: 0,
            name: "Name",
            status: "Status",
            species: "Species",
            type: "Type",
            gender: "Gender",
            origin: CharacterOriginResponse(name: "OriginName", url: "OriginUrl"),
            location: CharacterLocationResponse(name: "LocationName", url: "LocationUrl"),
            image: "Image"
        )
    }
    
    static func makeListInfoResponse() -> ListInfoResponse {
        ListInfoResponse(
            count: 1,
            pages: 1,
            next: "Next",
            previous: "Previous"
        )
    }
    
    static func makeListResponse() -> ListResponse<CharacterResponse> {
        ListResponse(
            info: makeListInfoResponse(),
            results: [makeCharacterResponse()]
        )
    }
}
