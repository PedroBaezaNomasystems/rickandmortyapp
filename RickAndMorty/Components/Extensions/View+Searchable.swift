import SwiftUI
import Presentation

extension View {
    
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
