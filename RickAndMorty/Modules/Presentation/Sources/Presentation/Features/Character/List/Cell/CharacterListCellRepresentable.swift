import SwiftUI

public protocol CharacterListCellRepresentable {
    var name: String { get }
    var image: String { get }
    var status: String { get }
    func onTapCharacter()
}
