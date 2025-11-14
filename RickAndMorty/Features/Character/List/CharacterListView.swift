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
        .alert(isPresented: $viewModel.isError) {
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

private extension View {
    
    @ViewBuilder
    func applySearchableIfNeeded(module: any Module) -> some View {
        if var searchable = module as? Searchable {
            let binding = Binding<String>(
                get: { searchable.search },
                set: { searchable.search = $0 }
            )
            
            self.searchable(
                text: binding,
                placement: .navigationBarDrawer,
                prompt: LocalizedStringKey("character_list_search_placeholder")
            )
            .onSubmit(of: .search) {
                searchable.onSearch()
            }
            .onChange(of: binding.wrappedValue) { _, newValue in
                if newValue.isEmpty {
                    searchable.onSearch()
                }
            }

        } else {
            self
        }
    }
}
