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
        VStack {
            renderer.render(module: viewModel.module)
        }
        .alert(isPresented: .constant(false)) {
            Alert(
                title: Text("character_list_error_title"),
                message: Text("character_list_error_message"),
                primaryButton: .default(Text("common_ok")),
                secondaryButton: .cancel()
            )
        }
        .navigationTitle("character_list_title")
    }
}
