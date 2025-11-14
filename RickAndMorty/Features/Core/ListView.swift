import SwiftUI
import Domain
import Combine
import Presentation

struct ListView: View {
    @State private var cells: [any Module] = []
    
    private let representable: any ListRepresentable
    private let cellRenderer: Renderer
    
    init(representable: any ListRepresentable, cellRenderer: Renderer) {
        self.representable = representable
        self.cellRenderer = cellRenderer
    }
    
    var body: some View {
        List {
            ForEach(cells, id: \.uuid) {
                cellRenderer.render(module: $0)
            }
        }
        .refreshable {
            representable.refresh()
        }
        .onReceive(representable.cells) {
            cells = $0
        }
        .overlay {
            if cells.isEmpty {
                ContentUnavailableView(
                    "common_list_empty",
                    systemImage: SystemIcon.persons.rawValue,
                    description: Text("common_pull_to_refresh")
                )
            }
        }
    }
}
