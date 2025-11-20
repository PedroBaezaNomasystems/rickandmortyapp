import Combine

public enum CharacterCellModuleEvent {
    case onTapCharacter(Int)
}

public protocol CharacterCellModule: Module {
    var id: Int { get }
    var eventSignal: AnyPublisher<CharacterCellModuleEvent, Never> { get }
}
