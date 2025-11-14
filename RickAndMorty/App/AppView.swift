import Presentation
import SwiftUI

struct AppView: View {
    @StateObject var router: Router = Router()
    
    private var renderer = ListRenderer(cellRenderer: CharacterListCellRenderer())
    
    var body: some View {
        NavigationStack(path: $router.navPath) {
            CharacterListView(renderer: renderer, router: router)
                .navigationDestination(for: Destination.self) { destination in
                    switch destination {
                    case .list:
                        CharacterListView(renderer: renderer, router: router)
                    case let .character(characterId):
                        CharacterDetailView(router: router, characterId: characterId)
                    }
                }
        }
    }
}
