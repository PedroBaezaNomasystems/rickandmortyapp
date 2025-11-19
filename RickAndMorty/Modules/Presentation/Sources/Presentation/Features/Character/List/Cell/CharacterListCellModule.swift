import Combine

public enum CharacterListCellModuleEvent {
    case onTapCharacter(Int)
}

public protocol CharacterListCellModule: Module {
    var id: Int { get }
    var eventSignal: AnyPublisher<CharacterListCellModuleEvent, Never> { get }
}
