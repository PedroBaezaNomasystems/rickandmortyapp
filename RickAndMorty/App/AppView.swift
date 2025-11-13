import Presentation
import SwiftUI

struct AppView: View {
    @StateObject var router: Router
    @StateObject var characterListViewModel: CharacterListViewModel
    
    private let renderer: CharacterListRenderer = CharacterListRenderer(cellRenderer: CharacterListCellRenderer())
    
    init() {
        let router = Router()
        self._router = StateObject(wrappedValue: router)
        self._characterListViewModel = StateObject(wrappedValue: CharacterListViewModel(router: router))
    }
    
    var body: some View {
        NavigationStack(path: $router.navPath) {
            renderer.render(module: characterListViewModel.module)
                .navigationDestination(for: Destination.self) { destination in
                    switch destination {
                    case .list:
                        renderer.render(module: characterListViewModel.module)
                    case let .character(characterId):
                        CharacterDetailView(router: router, characterId: characterId)
                    }
                }
        }
    }
}
