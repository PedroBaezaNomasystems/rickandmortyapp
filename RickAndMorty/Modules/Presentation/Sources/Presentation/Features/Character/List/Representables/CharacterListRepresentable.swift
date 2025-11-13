import SwiftUI

public protocol CharacterListRepresentable {
    var cells: [any Module] { get }
    func onRefresh(search: String) -> Void
}
