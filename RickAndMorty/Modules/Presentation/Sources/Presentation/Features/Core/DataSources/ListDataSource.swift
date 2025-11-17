import Combine

public final class ListDataSource: ObservableObject {
    @Published public var cells: [any Module]
    
    init(cells: [any Module]) {
        self.cells = cells
    }
}
