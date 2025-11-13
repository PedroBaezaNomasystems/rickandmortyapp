import SwiftUI

@MainActor
public protocol SUIRenderable: View {
    func eraseToAnyView() -> AnyView
}

public extension SUIRenderable {
    func eraseToAnyView() -> AnyView {
        AnyView(self)
    }
}
