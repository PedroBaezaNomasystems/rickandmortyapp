//
//  GetCharactersUseCase.swift
//  Domain
//
//  Created by Pedro Juan Baeza Gómez on 16/10/25.
//

import Foundation
import Factory

public protocol GetCharactersUseCase: UseCase where
    InputType == String,
    ResultType == ListEntity<CharacterEntity> {
        
    func reset()
}

public actor GetCharactersUseCaseImpl: GetCharactersUseCase {
    
    @Injected(\.characterRepository)
    private var repository: CharacterRepository!
    
    private var page: Int
    private var pages: Int
    private var search: String
    
    public init() {
        page = 1
        pages = 1
        search = ""
    }
    
    public func reset() {
        reset(data: search)
    }
    
    public func execute(data: String) async -> Result<ListEntity<CharacterEntity>, UseCaseError> {
        if data != search {
            reset(data: data)
        }
        
        guard page <= pages else { return .failure(.noMoreData) }
        do {
            let result = try await repository.getCharacters(page: page, search: data)
            
            page += 1
            pages = result.pages
            return .success(result)
        } catch {
            return .failure(.generic)
        }
    }
    
    private func reset(data: String) {
        page = 1
        pages = 1
        search = data
    }
}
