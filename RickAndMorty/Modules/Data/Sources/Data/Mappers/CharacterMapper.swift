//
//  CharacterMapper.swift
//  Data
//
//  Created by Pedro Juan Baeza Gómez on 15/10/25.
//

import Domain

extension CharacterResponse: Mappeable {
    
    func toDomain() -> CharacterEntity {
        
        .init(id: id,
              name: name,
              status: status,
              species: species,
              type: type,
              gender: gender,
              origin: origin.name,
              location: location.name,
              image: image)
    }
}
