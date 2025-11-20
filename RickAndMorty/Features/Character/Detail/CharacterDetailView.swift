import SwiftUI
import Domain
import Presentation

struct CharacterDetailView: View {
    @StateObject var viewModel: CharacterDetailViewModel
    
    private let renderer: Renderer
    
    init(renderer: Renderer, characterId: Int = 1, router: Routing? = nil) {
        self._viewModel = StateObject(wrappedValue: CharacterDetailViewModel(characterId: characterId, router: router))
        self.renderer = renderer
    }
    
    var body: some View {
        renderer.render(module: viewModel.module)
            .navigationTitle("character_detail_title")
    }
}
