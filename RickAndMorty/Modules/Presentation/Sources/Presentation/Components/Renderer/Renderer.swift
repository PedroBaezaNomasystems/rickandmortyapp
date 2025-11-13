import SwiftUI

public protocol Renderer {
    func render(module: any Module) -> AnyView
}
