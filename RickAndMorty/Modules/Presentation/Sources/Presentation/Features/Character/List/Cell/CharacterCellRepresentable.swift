import SwiftUI

public protocol CharacterCellRepresentable {
    var name: String { get }
    var image: String { get }
    var status: String { get }
    func onTapCharacter()
}
