import SwiftUI
import Domain
import Combine
import Presentation

struct ListView: View {
    @StateObject private var dataSource: ListDataSource
    private let representable: any ListRepresentable
    private let cellRenderer: Renderer
    
    init(representable: any ListRepresentable, cellRenderer: Renderer) {
        self._dataSource = StateObject(wrappedValue: representable.listDataSource)
        self.representable = representable
        self.cellRenderer = cellRenderer
    }
    
    var body: some View {
        List {
            ForEach(dataSource.cells, id: \.uuid) {
                cellRenderer.render(module: $0)
            }
        }
        .refreshable {
            representable.refresh()
        }
        .overlay {
            if dataSource.cells.isEmpty {
                ContentUnavailableView(
                    "common_list_empty",
                    systemImage: SystemIcon.persons.rawValue,
                    description: Text("common_pull_to_refresh")
                )
            }
        }
    }
}
