import SwiftUI
import Presentation

public struct ErrorRenderer {
    
}

extension ErrorRenderer: Renderer {
    public func render(module: any Module) -> AnyView {
        switch module {
        case (let representable as any ErrorRepresentable):
            AnyView(ErrorView(representable: representable))
        default:
            EmptyRenderer().render(module: module)
        }
    }
}
