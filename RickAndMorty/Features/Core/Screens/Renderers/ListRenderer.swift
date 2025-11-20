import SwiftUI
import Presentation

public struct ListRenderer {
    let cellRenderer: Renderer
    
    public init(cellRenderer: Renderer) {
        self.cellRenderer = cellRenderer
    }
}

extension ListRenderer: Renderer {
    public func render(module: any Module) -> AnyView {
        switch module {
        case (let representable as any ListRepresentable & SearchRepresentable):
            AnyView(SearchListView(representable: representable, cellRenderer: cellRenderer))
        case (let representable as any ListRepresentable):
            AnyView(ListView(representable: representable, cellRenderer: cellRenderer))
        default:
            AnyView(SwiftUI.EmptyView())
        }
    }
}
