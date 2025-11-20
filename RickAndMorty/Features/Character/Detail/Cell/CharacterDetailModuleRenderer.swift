import SwiftUI
import Presentation

public struct CharacterDetailModuleRenderer {
    
}

extension CharacterDetailModuleRenderer: Renderer {
    public func render(module: any Module) -> AnyView {
        switch module {
        default:
            EmptyRenderer().render(module: module)
        }
    }
}
