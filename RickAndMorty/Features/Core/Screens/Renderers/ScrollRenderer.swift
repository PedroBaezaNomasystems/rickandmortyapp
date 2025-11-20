import SwiftUI
import Presentation

public struct ScrollRenderer {
    let moduleRenderer: Renderer
    
    public init(moduleRenderer: Renderer) {
        self.moduleRenderer = moduleRenderer
    }
}

extension ScrollRenderer: Renderer {
    public func render(module: any Module) -> AnyView {
        switch module {
        case (let representable as any ScrollRepresentable):
            AnyView(ScrollView(representable: representable, moduleRenderer: moduleRenderer))
        default:
            AnyView(SwiftUI.EmptyView())
        }
    }
}
