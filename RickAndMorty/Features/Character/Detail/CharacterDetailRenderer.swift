import SwiftUI
import Presentation

public struct CharacterDetailRenderer {
    let moduleRenderer: Renderer
    
    public init(moduleRenderer: Renderer) {
        self.moduleRenderer = moduleRenderer
    }
}

extension CharacterDetailRenderer: Renderer {
    public func render(module: any Module) -> AnyView {
        switch module {
        case ( _ as any ErrorRepresentable):
            ErrorRenderer().render(module: module)
        default:
            ScrollRenderer(moduleRenderer: moduleRenderer).render(module: module)
        }
    }
}
