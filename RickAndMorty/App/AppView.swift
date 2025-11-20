import Presentation
import SwiftUI

struct AppView: View {
    @StateObject var router: Router = Router()
    
    private var listRenderer = CharacterListRenderer(cellRenderer: CharacterListCellRenderer())
    private var detailRenderer = CharacterDetailRenderer(moduleRenderer: CharacterDetailModuleRenderer())
    
    var body: some View {
        NavigationStack(path: $router.navPath) {
            CharacterListView(renderer: listRenderer, router: router)
                .navigationDestination(for: Destination.self) { destination in
                    switch destination {
                    case .list:
                        CharacterListView(renderer: listRenderer, router: router)
                    case let .character(characterId):
                        CharacterDetailView(renderer: detailRenderer, characterId: characterId, router: router)
                    }
                }
        }
    }
}
