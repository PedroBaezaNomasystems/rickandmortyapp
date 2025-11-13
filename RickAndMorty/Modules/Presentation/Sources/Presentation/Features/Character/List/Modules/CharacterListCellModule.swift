import Combine
import SwiftUI

public enum CharacterListCellModuleEvent {
    case tapCharacter(Int)
    case appearCharacter(Int)
}

public protocol CharacterListCellModule: Module {
    var id: Int { get }
    var eventSignal: AnyPublisher<CharacterListCellModuleEvent, Never> { get }
}
