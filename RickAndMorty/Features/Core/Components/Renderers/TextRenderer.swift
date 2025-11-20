import SwiftUI
import Presentation

public struct TextRenderer {
    
}

extension TextRenderer: Renderer {
    public func render(module: any Module) -> AnyView {
        switch module {
        case (let representable as any TextRepresentable):
            AnyView(TextView(representable: representable))
        default:
            EmptyRenderer().render(module: module)
        }
    }
}
