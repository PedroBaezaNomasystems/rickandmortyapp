import Combine
import Domain
import Factory
import SwiftUI

@MainActor
public class CharacterListViewModel: ObservableObject {
    @Published public var module: any CharacterListModule
    @Published public var modules: [any CharacterListCellModule] = [] {
        didSet {
            module = CharacterListModel(cells: modules)
        }
    }
    
    private var router: Routing?
    private var cancellables: [AnyCancellable]
    
    @Injected(\.getCharactersUseCase)
    private var getCharactersUseCase: (any GetCharactersUseCase)!
    
    //TODO: Delete this vars after create module.
    @Published public var isError = false
    @Published public var isLoading = false
    @Published public var totalPages: Int = 1
    @Published public var currentPage: Int = 1
    
    public init(router: Routing?) {
        self.module = CharacterListModel(cells: [])
        self.modules = []
        self.router = router
        self.cancellables = []
        
        initListeners()
    }
    
    func initListeners() {
        module.eventSignal.sink { event in
            switch event {
            case .onRefresh(let search): self.onReresh(search)
            }
        }
        .store(in: &cancellables)
    }
}

private extension CharacterListViewModel {
    
    func onReresh(_ search: String) {
        Task {
            await fetchFirstPage(search: search)
        }
    }
    
    func fetchFirstPage(search: String) async {
        totalPages = 1
        currentPage = 1
        modules.removeAll()
        
        await fetchPage(search: search)
    }
    
    func fetchNextPage(search: String) async {
        currentPage += 1
        
        if currentPage <= totalPages {
            await fetchPage(search: search)
        }
    }
    
    func fetchPage(search: String) async {
        isLoading = true
        
        let result = await getCharactersUseCase.execute(data: (page: currentPage, search: search))
        switch result {
        case .success(let response):
            let cells = CharacterListCellFactory.makeModules(characters: response.results)
            cells.forEach { cell in
                cell.eventSignal.sink { event in
                    switch event {
                    case .tapCharacter(let id): self.onTapCharacter(id)
                    case .appearCharacter(let id): self.onAppearCharacter(id)
                    }
                }
                .store(in: &cancellables)
            }
            
            totalPages = response.pages
            modules.append(contentsOf: cells)
        case .failure:
            isError = true
        }
        
        isLoading = false
    }
    
    func onTapCharacter(_ id: Int) {
        router?.navigate(to: .character("\(id)"))
    }
    
    func onAppearCharacter(_ id: Int) {
        guard let lastModule = modules.last, id == lastModule.id else { return }
        Task {
            await self.fetchNextPage(search: "")
        }
    }
}
