import SwiftUI
import Presentation

public struct LoadingRenderer {
    
}

extension LoadingRenderer: Renderer {
    public func render(module: any Module) -> AnyView {
        switch module {
        case (let representable as any LoadingRepresentable):
            AnyView(LoadingView(representable: representable))
        default:
            AnyView(SwiftUI.EmptyView())
        }
    }
}
