import SwiftUI
import Presentation

public struct ComponentRenderer {
    
}

extension ComponentRenderer: Renderer {
    public func render(module: any Module) -> AnyView {
        switch module {
        case (let representable as any TextRepresentable):
            AnyView(TextView(representable: representable))
        case (let representable as any EmptyRepresentable):
            AnyView(EmptyView(representable: representable))
        default:
            AnyView(SwiftUI.EmptyView())
        }
    }
}
