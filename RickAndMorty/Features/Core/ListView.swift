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
            ForEach(cells, id: \.uuid) { cell in
                cellRenderer.render(module: cell)
            }
        }
        .onReceive(representable.cellsPublisher) { representableCells in
            cells = representableCells
        }
        .refreshable {
            representable.refresh()
        }
        .overlay {
            if cells.isEmpty {
                ContentUnavailableView(
                    "character_list_empty_list",
                    systemImage: SystemIcon.persons.rawValue,
                    description: Text("common_pull_to_refresh")
                )
            }
        }
    }
}
