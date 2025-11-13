import SwiftUI
import Presentation

public struct CharacterListRenderer {
    let cellRenderer: Renderer
    
    public init(cellRenderer: Renderer) {
        self.cellRenderer = cellRenderer
    }
}

extension CharacterListRenderer: Renderer {
    
    public func render(module: any Module) -> AnyView {
        switch module {
        case (let representable as CharacterListRepresentable):
            AnyView(CharacterListView(representable: representable, cellRenderer: cellRenderer))
        default:
            AnyView(EmptyView())
        }
    }
}
