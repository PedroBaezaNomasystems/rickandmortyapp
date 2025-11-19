import Combine
import Domain
import Factory
import SwiftUI

@MainActor
public class CharacterListViewModel: ObservableObject {
    @Published public var module: any Module
    
    private var listCancellables: [AnyCancellable]
    private var listModule: any ListModule & ListInfiniteModule & SearchModule {
        didSet { initListListeners() }
    }
    
    private var errorCancellables: [AnyCancellable]
    private var errorModule: any ErrorModule {
        didSet { initErrorListeners() }
    }
    
    private var router: Routing?
    
    @Injected(\.getCharactersUseCase)
    private var getCharactersUseCase: (any GetCharactersUseCase)!
    
    public init(router: Routing?) {
        self.module = CharacterListFactory.makeEmptyModule()
        self.listCancellables = []
        self.listModule = CharacterListFactory.makeListModule()
        self.errorCancellables = []
        self.errorModule = CharacterListFactory.makeErrorModule()
        self.router = router
        
        self.setup()
    }
    
    private func setup() {
        self.initListListeners()
        self.initErrorListeners()
        self.module = makeListModule()
    }
}

private extension CharacterListViewModel {
    
    func initListListeners() {
        listCancellables = []
        
        listModule.listEventSignal.sink { event in
            switch event {
            case .onRefresh: self.onFirstPage()
            }
        }
        .store(in: &listCancellables)
        
        listModule.searchEventSignal.sink { event in
            switch event {
            case .onSubmit: self.onFirstPage()
            }
        }
        .store(in: &listCancellables)
    }
    
    func initErrorListeners() {
        errorCancellables = []
        
        errorModule.eventSignal.sink { event in
            switch event {
            case .onRetry: self.onRetry()
            }
        }
        .store(in: &errorCancellables)
    }
}

private extension CharacterListViewModel {
    
    func onRetry() {
        module = makeListModule()
        onFirstPage()
    }
    
    func onFirstPage() {
        Task {
            listModule.clearModules()
            await getCharactersUseCase.reset()
            await onFetchPage()
        }
    }
    
    func onNextPage() {
        Task {
            await onFetchPage()
        }
    }
    
    func onFetchPage() async {
        let result = await getCharactersUseCase.execute(data: listModule.search)
        switch result {
        case .failure(let error):
            switch error {
            case .noMoreData: module = makeListNoMoreDataModule()
            case .generic: module = makeErrorModule(error: error.localizedDescription)
            }
        case .success(let response):
            module = makeListModule(pages: response.pages, characters: response.results)
        }
    }
}

private extension CharacterListViewModel {
    
    func makeErrorModule(error: String) -> any Module {
        errorModule = CharacterListFactory.makeErrorModule(error: error)
        return errorModule
    }
    
    func makeListModule() -> any Module {
        listModule = CharacterListFactory.makeListModule()
        return listModule
    }
    
    func makeListNoMoreDataModule() -> any Module {
        listModule.clearLoadingModules()
        return listModule
    }
    
    func makeListModule(pages: Int, characters: [CharacterEntity]) -> any Module {
        listModule.clearLoadingModules()
        listModule.appendModules(makeListCellModules(characters: characters))
        return listModule
    }
    
    func makeListCellModules(characters: [CharacterEntity]) -> [any Module] {
        var modules: [any Module] = []
        
        let characters = CharacterListCellFactory.makeCharactersModules(characters)
        characters.forEach { cell in
            cell.eventSignal.sink { event in
                switch event {
                case .onTapCharacter(let id): self.router?.navigate(to: .character(id))
                }
            }
            .store(in: &listCancellables)
        }
        
        let loading = CharacterListCellFactory.makeLoadingModule()
        loading.isLoading.sink { isLoading in
            guard isLoading else { return }
            self.onNextPage()
        }
        .store(in: &listCancellables)
        
        modules.append(contentsOf: characters)
        modules.append(loading)
        
        return modules
    }
}
