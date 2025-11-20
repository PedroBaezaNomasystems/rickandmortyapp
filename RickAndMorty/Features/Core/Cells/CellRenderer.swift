import SwiftUI
import Presentation

public struct CellRenderer {
    
}

extension CellRenderer: Renderer {
    public func render(module: any Module) -> AnyView {
        switch module {
        case (let representable as any CellLoadingRepresentable):
            AnyView(CellLoadingView(representable: representable))
        default:
            AnyView(SwiftUI.EmptyView())
        }
    }
}
