import SwiftUI
import Presentation

public struct ListCellRenderer {
    
}

extension ListCellRenderer: Renderer {
    public func render(module: any Module) -> AnyView {
        switch module {
        case (let representable as any ListCellLoadingRepresentable):
            AnyView(ListCellLoadingView(representable: representable))
        default:
            AnyView(EmptyView())
        }
    }
}
