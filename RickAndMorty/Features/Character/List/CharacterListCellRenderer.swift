import SwiftUI
import Presentation

public struct CharacterListCellRenderer {
    
}

extension CharacterListCellRenderer: Renderer {
    
    public func render(module: any Module) -> AnyView {
        switch module {
        case (let representable as CharacterListCellRepresentable):
            AnyView(CharacterListCellView(representable: representable))
        default:
            AnyView(EmptyView())
        }
    }
}
