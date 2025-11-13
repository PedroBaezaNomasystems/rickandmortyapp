//
//  CharacterListViewModel.swift
//  Presentation
//
//  Created by Pedro Juan Baeza Gómez on 15/10/25.
//

import SwiftUI
import Domain
import Combine
import Factory

@MainActor
public class CharacterListV2ViewModel: ObservableObject {
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

private extension CharacterListV2ViewModel {
    
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
            totalPages = response.pages
            modules.append(contentsOf: makeModules(characters: response.results))
        case .failure:
            isError = true
        }
        
        isLoading = false
    }
    
    func makeModules(characters: [CharacterEntity]) -> [any Module] {
        let modules: [any CharacterModule] = characters.map { character in
            CharacterModelUI(
                id: character.id,
                name: character.name,
                image: character.image,
                status: character.status
            )
        }
        
        modules.forEach { module in
            module.eventSignal.sink { event in
                switch event {
                case .tapCharacter(let id):
                    router?.navigate(to: .character("\(id)"))
                case .appearCharacter(let id):
                    if let last = self.modules.last as? (any CharacterModule), id == last.id {
                        Task {
                            await self.fetchNextPage()
                        }
                    }
                }
            }
            .store(in: &cancellables)
        }
        
        return modules
    }
}
