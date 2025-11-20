import SwiftUI
import Presentation

public struct ScreenRenderer {
    let childrenRenderer: Renderer?
    
    public init(childrenRenderer: Renderer? = nil) {
        self.childrenRenderer = childrenRenderer
    }
}

extension ScreenRenderer: Renderer {
    public func render(module: any Module) -> AnyView {
        switch module {
        case ( _ as any ScrollRepresentable):
            guard let moduleRenderer = childrenRenderer else { fatalError() }
            return ScrollRenderer(moduleRenderer: moduleRenderer).render(module: module)
        case ( _ as any ListRepresentable):
            guard let cellRenderer = childrenRenderer else { fatalError() }
            return ListRenderer(cellRenderer: cellRenderer).render(module: module)
        case ( _ as any LoadingRepresentable):
            return LoadingRenderer().render(module: module)
        case ( _ as any ErrorRepresentable):
            return ErrorRenderer().render(module: module)
        default:
            return AnyView(SwiftUI.EmptyView())
        }
    }
}
