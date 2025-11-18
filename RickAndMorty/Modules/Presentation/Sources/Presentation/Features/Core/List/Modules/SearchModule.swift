import Combine

public enum SearchModuleEvent {
    case onSubmit
}

public protocol SearchModule: Module {
    var search: String { get }
    var searchPublisher: Published<String>.Publisher { get }
    var searchEventSignal: AnyPublisher<SearchModuleEvent, Never> { get }
}
