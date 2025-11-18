import SwiftUI
import Domain
import Presentation

struct CharacterListView: View {
    @StateObject var viewModel: CharacterListViewModel
    
    private let renderer: Renderer
    
    init(renderer: Renderer, router: Routing? = nil) {
        self._viewModel = StateObject(wrappedValue: CharacterListViewModel(router: router))
        self.renderer = renderer
    }
    
    var body: some View {
        renderer.render(module: viewModel.module)
            .navigationTitle("character_list_title")
    }
}
