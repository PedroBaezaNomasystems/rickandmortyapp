//
//  ListMapper.swift
//  Data
//
//  Created by Pedro Juan Baeza Gómez on 16/10/25.
//

import Domain

extension ListResponse: Mappeable where T: Mappeable {
    
    func toDomain() -> ListEntity<T.Entity> {
        
        .init(count: info.count,
              pages: info.pages,
              next: info.next,
              previous: info.previous,
              results: results.map { $0.toDomain() })
    }
}
