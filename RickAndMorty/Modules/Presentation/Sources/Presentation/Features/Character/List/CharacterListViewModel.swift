import Combine
import Domain
import Factory
import SwiftUI

@MainActor
public class CharacterListViewModel: ObservableObject {
    @Published public var module: any ListModule
    
    private var router: Routing?
    private var cancellables: [AnyCancellable]
    
    @Injected(\.getCharactersUseCase)
    private var getCharactersUseCase: (any GetCharactersUseCase)!
    
    public init(router: Routing?) {
        self.module = ListModel(cells: [])
        self.router = router
        self.cancellables = []
        
        initListeners()
    }
    
    func initListeners() {
        module.eventSignal.sink { event in
            switch event {
            case .onRefresh: self.onReresh()
            }
        }
        .store(in: &cancellables)
    }
}

private extension CharacterListViewModel {
    func onReresh() {
        Task {
            await fetchPage()
        }
    }
    
    func fetchPage() async {
        let result = await getCharactersUseCase.execute(data: (page: 1, search: ""))
        switch result {
        case .success(let response):
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
        
        modules.append(contentsOf: characters)
        
        return modules
    }
}
