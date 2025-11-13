//
//  CharacterListViewModel.swift
//  Presentation
//
//  Created by Pedro Juan Baeza Gómez on 15/10/25.
//

import Combine
import Domain
import Factory
import SwiftUI

@MainActor
public class CharacterListViewModel: ObservableObject {
    @Published public var modules: [any Module]
    
    @Published public var isError = false
    @Published public var isLoading = false
    @Published public var search: String = ""
    @Published public var totalPages: Int = 1
    @Published public var currentPage: Int = 1
    
    private var router: Routing?
    private var cancellables: [AnyCancellable]
    
    @Injected(\.getCharactersUseCase)
    private var getCharactersUseCase: (any GetCharactersUseCase)!
    
    public init(router: Routing?) {
        self.modules = []
        self.router = router
        self.cancellables = []
    }
    
    public func onRefresh() async {        
        await fetchFirstPage()
    }
}

private extension CharacterListViewModel {
    
    func fetchFirstPage() async {
        modules = []
        totalPages = 1
        currentPage = 1
        
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
            let modules = CharacterListCellFactory.makeModules(characters: response.results)
            modules.forEach { module in
                module.eventSignal.sink { event in
                    switch event {
                    case .tapCharacter(let id):
                        self.router?.navigate(to: .character("\(id)"))
                    case .appearCharacter(let id):
                        if let last = self.modules.last as? (any CharacterListCellModule), id == last.id {
                            Task {
                                await self.fetchNextPage()
                            }
                        }
                    }
                }
                .store(in: &cancellables)
            }
            
            self.totalPages = response.pages
            self.modules.append(contentsOf: modules)
        case .failure:
            isError = true
        }
        
        isLoading = false
    }
}
