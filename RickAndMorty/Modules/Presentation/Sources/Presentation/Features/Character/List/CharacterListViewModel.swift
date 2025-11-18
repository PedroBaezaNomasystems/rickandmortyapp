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
        self.module = ListInfiniteSearchModel(searchModel: ListSearchModel(listModel: ListModel(cells: [])))
        self.router = router
        self.cancellables = []
        
        initListeners()
    }
    
    func initListeners() {
        module.listEventSignal.sink { event in
            switch event {
            case .onRefresh: self.onFirstPage()
            }
        }
        .store(in: &cancellables)
        
        module.searchEventSignal.sink { event in
            switch event {
            case .onSubmit: self.onFirstPage()
            }
        }
        .store(in: &cancellables)
    }
}

private extension CharacterListViewModel {
    func onFirstPage() {
        Task {
            module.prepareFirstPage()
            module.clearModules()
            await fetchPage()
        }
    }
    
    func onNextPage() {
        Task {
            await fetchPage()
        }
    }
    
    func fetchPage() async {
        let result = await getCharactersUseCase.execute(data: (page: module.current, search: module.search))
        switch result {
        case .success(let response):
            module.prepareNextPage(pages: response.pages)
            module.appendModules(makeModules(characters: response.results))
        case .failure:
            break
        }
    }
    
    func makeModules(characters: [CharacterEntity]) -> [any Module] {
        var modules: [any Module] = []
        
        let characters = CharacterListFactory.makeCharactersModules(characters)
        characters.forEach { cell in
            cell.eventSignal.sink { event in
                switch event {
                case .tapCharacter(let id): self.router?.navigate(to: .character("\(id)"))
                }
            }
            .store(in: &cancellables)
        }
        
        let loading = CharacterListFactory.makeLoadingModule()
        loading.isLoading.sink { isLoading in
            guard isLoading, self.module.thereAreMorePages else { return }
            self.onNextPage()
        }
        .store(in: &cancellables)
        
        modules.append(contentsOf: characters)
        modules.append(loading)
        
        return modules
    }
}
