//
//  CharacterListViewModel.swift
//  Presentation
//
//  Created by Pedro Juan Baeza Gómez on 15/10/25.
//

import SwiftUI
import Domain
import Factory

@MainActor
public class CharacterListViewModel: ObservableObject {
    
    @Published public var isError = false
    @Published public var isLoading = false
    @Published public var search: String = ""
    @Published public var totalPages: Int = 1
    @Published public var currentPage: Int = 1
    @Published public var characters: [CharacterEntity] = []
    
    private var router: Routing?
    
    @Injected(\.getCharactersUseCase)
    private var getCharactersUseCase: (any GetCharactersUseCase)!
    
    public init(router: Routing?) {
        
        self.router = router
    }
    
    public func onRefresh() async {
        
        await fetchFirstPage()
    }
    
    public func onRequestMoreCharacters() async {
        
        await fetchNextPage()
    }
    
    public func onClickOnCharacter(id: Int) {
        
        router?.navigate(to: .character("\(id)"))
    }
}

private extension CharacterListViewModel {
    
    func fetchFirstPage() async {
        
        totalPages = 1
        currentPage = 1
        characters = []
        
        await fetchPage()
    }
    
    func fetchNextPage() async {
        
        currentPage += 1
        
        if currentPage <= totalPages {
            
            await fetchPage()
        }
    }
    
    func fetchPage() async {
        
        isLoading = true
        
        let result = await getCharactersUseCase.execute(data: (page: currentPage, search: search))
        switch result {
        case .success(let response):
            totalPages = response.pages
            characters.append(contentsOf: response.results)
        case .failure:
            isError = true
        }
        
        isLoading = false
    }
}
