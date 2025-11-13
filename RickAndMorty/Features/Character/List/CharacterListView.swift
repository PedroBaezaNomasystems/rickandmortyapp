import SwiftUI
import Domain
import Combine
import Presentation

struct CharacterListView: View {
    @State private var search: String = ""
    
    private let representable: CharacterListRepresentable
    private let cellRenderer: Renderer
    
    init(representable: CharacterListRepresentable, cellRenderer: Renderer) {
        self.representable = representable
        self.cellRenderer = cellRenderer
    }
    
    var body: some View {
        VStack {
            List {
                ForEach(representable.cells, id: \.uuid) { cell in
                    cellRenderer.render(module: cell)
                }
                
                /*if !viewModel.isLoading && !viewModel.modules.isEmpty {
                 ListProgress()
                 }*/
            }
            .searchable(
                text: $search,
                placement: .navigationBarDrawer,
                prompt: "character_list_search_placeholder"
            )
            .onSubmit(of: .search) {
                representable.onRefresh(search: search)
            }
            .onChange(of: search) { oldValue, newValue in
                if newValue.isEmpty {
                    representable.onRefresh(search: search)
                }
            }
            .refreshable {
                representable.onRefresh(search: search)
            }
            .overlay {
                if representable.cells.isEmpty {
                    ContentUnavailableView(
                        "character_list_empty_list",
                        systemImage: SystemIcon.persons.rawValue,
                        description: Text("common_pull_to_refresh")
                    )
                }
            }
        }
        /*.alert(isPresented: $viewModel.isError) {
            Alert(
                title: Text("character_list_error_title"),
                message: Text("character_list_error_message"),
                primaryButton: .default(Text("common_ok")),
                secondaryButton: .cancel()
            )
        }*/
        .navigationTitle("character_list_title")
    }
}
