import SwiftUI
import Domain
import Combine
import Presentation

struct SearchListView: View {
    @StateObject private var dataSource: SearchDataSource
    private let representable: any ListRepresentable & SearchRepresentable
    private let cellRenderer: Renderer
    
    init(representable: any ListRepresentable & SearchRepresentable, cellRenderer: Renderer) {
        self._dataSource = StateObject(wrappedValue: representable.searchDataSource)
        self.representable = representable
        self.cellRenderer = cellRenderer
    }
    
    var body: some View {
        ListView(representable: representable, cellRenderer: cellRenderer)
            .searchable(
                text: $dataSource.search,
                placement: .navigationBarDrawer,
                prompt: LocalizedStringKey("common_search_placeholder")
            )
            .onSubmit(of: .search) {
                representable.onSubmit()
            }
    }
}
