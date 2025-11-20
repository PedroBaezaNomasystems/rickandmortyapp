import SwiftUI
import Presentation

public struct CharacterCellRenderer {
    
}

extension CharacterCellRenderer: Renderer {
    public func render(module: any Module) -> AnyView {
        switch module {
        case (let representable as any CharacterCellRepresentable):
            AnyView(CharacterCellView(representable: representable))
        default:
            CellRenderer().render(module: module)
        }
    }
}
