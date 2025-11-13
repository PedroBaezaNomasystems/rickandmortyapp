import Combine
import Domain
import Factory
import SwiftUI

@MainActor
public class CharacterListViewModel: ObservableObject {
    @Published public var modules: [any Module]
    
    private var router: Routing?
    private var cancellables: [AnyCancellable]
    
    @Injected(\.getCharactersUseCase)
    private var getCharactersUseCase: (any GetCharactersUseCase)!
    
    //TODO: Delete this vars after create module.
    @Published public var isError = false
    @Published public var isLoading = false
    @Published public var search: String = ""
    @Published public var totalPages: Int = 1
    @Published public var currentPage: Int = 1
    
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
            let modules = CharacterListCellFactory.makeModules(
                characters: response.results,
                onTap: onTapCharacter,
                onAppear: onAppearCharacter,
                cancellables: &cancellables
            )
            
            self.totalPages = response.pages
            self.modules.append(contentsOf: modules)
        case .failure:
            isError = true
        }
        
        isLoading = false
    }
    
    func onTapCharacter(id: Int) {
        router?.navigate(to: .character("\(id)"))
    }
    
    func onAppearCharacter(id: Int) {
        guard let lastModule = modules.last as? (any CharacterListCellModule), id == lastModule.id else {
            return
        }
        
        Task {
            await self.fetchNextPage()
        }
    }
}
