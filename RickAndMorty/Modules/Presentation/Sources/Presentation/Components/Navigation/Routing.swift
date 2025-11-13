import SwiftUI

public protocol Routing {
    func navigate(to route: Destination)
    func navigateBack()
    func navigateToRoot()
}
