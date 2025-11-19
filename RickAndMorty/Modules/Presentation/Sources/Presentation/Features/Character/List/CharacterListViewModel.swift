import Combine
import Domain
import Factory
import SwiftUI

@MainActor
public class CharacterListViewModel: ObservableObject {
    @Published public var module: any Module {
        didSet { initListeners() }
    }
    
    private var router: Routing?
    private var cancellables: [AnyCancellable]
    
    @Injected(\.getCharactersUseCase)
    private var getCharactersUseCase: (any GetCharactersUseCase)!
    
    public init(router: Routing?) {
        self.module = CharacterListFactory.makeErrorModule(error: "Something went wrong")
        self.router = router
        self.cancellables = []
        self.initListeners()
    }
}

private extension CharacterListViewModel {
    func initListeners() {
        cancellables = []
        
        if listModule != nil {
            initListListeners()
        } else if errorModule != nil {
            initErrorListeners()
        }
    }
    
    func initListListeners() {
        guard let listModule = listModule else { return }
        listModule.listEventSignal.sink { event in
            switch event {
            case .onRefresh: self.onFirstPage()
            }
        }
        .store(in: &cancellables)
        
        listModule.searchEventSignal.sink { event in
            switch event {
            case .onSubmit: self.onFirstPage()
            }
        }
        .store(in: &cancellables)
    }
    
    func initErrorListeners() {
        guard let errorModule = errorModule else { return }
        errorModule.eventSignal.sink { event in
            switch event {
            case .onRetry: self.onRetry()
            }
        }
        .store(in: &cancellables)
    }
}

private extension CharacterListViewModel {
    func onRetry() {
        module = CharacterListFactory.makeListModule()
        onFirstPage()
    }
    
    func onFirstPage() {
        Task {
            guard let listModule = listModule else { return }
            listModule.prepareFirstPage()
            listModule.clearModules()
            await fetchPage()
        }
    }
    
    func onNextPage() {
        Task {
            await fetchPage()
        }
    }
    
    func fetchPage() async {
        guard let listModule = listModule else { return }
        let result = await getCharactersUseCase.execute(data: (page: listModule.current, search: listModule.search))
        switch result {
        case .success(let response):
            listModule.prepareNextPage(pages: response.pages)
            
            listModule.clearLoadingModules()
            listModule.appendModules(makeListCellModules(characters: response.results))
        case .failure(let error):
            module = CharacterListFactory.makeErrorModule(error: error.localizedDescription)
        }
    }
}

private extension CharacterListViewModel {
    func makeListCellModules(characters: [CharacterEntity]) -> [any Module] {
        var modules: [any Module] = []
        
        let characters = CharacterListCellFactory.makeCharactersModules(characters)
        characters.forEach { cell in
            cell.eventSignal.sink { event in
                switch event {
                case .onTapCharacter(let id): self.router?.navigate(to: .character("\(id)"))
                }
            }
            .store(in: &cancellables)
        }
        
        let loading = CharacterListCellFactory.makeLoadingModule()
        loading.isLoading.sink { isLoading in
            guard let listModule = self.listModule else { return }
            guard isLoading, listModule.thereAreMorePages else {
                listModule.clearLoadingModules()
                return
            }
            
            self.onNextPage()
        }
        .store(in: &cancellables)
        
        modules.append(contentsOf: characters)
        modules.append(loading)
        
        return modules
    }
}
