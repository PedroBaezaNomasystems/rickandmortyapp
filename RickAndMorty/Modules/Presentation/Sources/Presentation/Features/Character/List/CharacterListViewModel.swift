import Combine
import Domain
import Factory
import SwiftUI

@MainActor
public class CharacterListViewModel: ObservableObject {
    @Published public var module: any ListModule & ListInfiniteModule & SearchModule
    
    private var router: Routing?
    private var cancellables: [AnyCancellable]
    
    @Injected(\.getCharactersUseCase)
    private var getCharactersUseCase: (any GetCharactersUseCase)!
    
    public init(router: Routing?) {
        self.module = ListInfiniteSearchModel(pages: 1, current: 1, searchModel: ListSearchModel(listModel: ListModel(cells: [])))
        self.router = router
        self.cancellables = []
        
        initListeners()
    }
    
    func initListeners() {
        module.listSignal.sink { event in
            switch event {
            case .onRefresh: self.onReresh()
            }
        }
        .store(in: &cancellables)
        
        module.searchSignal.sink { event in
            switch event {
            case let .onSubmit(search): self.onSearchSubmit(search)
            }
        }
        .store(in: &cancellables)
    }
}

private extension CharacterListViewModel {
    func onReresh() {
        onFirstPage()
    }
    
    func onSearchSubmit(_ search: String) {
        onFirstPage(search: search)
    }
    
    func onFirstPage(search: String = "") {
        Task {
            module.pages = 42
            module.current = 40
            module.clearModules()
            
            await fetchPage(search: search)
        }
    }
    
    func onNextPage() {
        Task {
            module.current += 1
            
            guard module.current <= module.pages else {
                module.clearLoadingModules()
                return
            }
            await fetchPage()
        }
    }
    
    func fetchPage(search: String = "") async {
        let result = await getCharactersUseCase.execute(data: (page: module.current, search: search))
        switch result {
        case .success(let response):
            module.pages = response.pages
            module.appendModules(makeModules(characters: response.results))
        case .failure:
            break
        }
    }
    
    func makeModules(characters: [CharacterEntity]) -> [any Module] {
        var modules: [any Module] = []
        
        let characters = CharacterListCellFactory.makeModules(characters: characters)
        characters.forEach { cell in
            cell.eventSignal.sink { event in
                switch event {
                case .tapCharacter(let id): self.router?.navigate(to: .character("\(id)"))
                }
            }
            .store(in: &cancellables)
        }
        
        let loading = ListCellLoadingModel()
        loading.isLoading.sink { isLoading in
            if isLoading {
                self.onNextPage()
            }
        }
        .store(in: &cancellables)
        
        modules.append(contentsOf: characters)
        modules.append(loading)
        
        return modules
    }
}
