import Combine

public enum CharacterListModuleEvent {
    case onRefresh(String)
}

public protocol CharacterListModule: Module {
    var eventSignal: AnyPublisher<CharacterListModuleEvent, Never> { get }
}
