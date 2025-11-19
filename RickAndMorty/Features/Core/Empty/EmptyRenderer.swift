import SwiftUI
import Presentation

public struct EmptyRenderer {
    
}

extension EmptyRenderer: Renderer {
    public func render(module: any Module) -> AnyView {
        switch module {
        case (let representable as any EmptyRepresentable):
            AnyView(EmptyView(representable: representable))
        default:
            AnyView(SwiftUI.EmptyView())
        }
    }
}
