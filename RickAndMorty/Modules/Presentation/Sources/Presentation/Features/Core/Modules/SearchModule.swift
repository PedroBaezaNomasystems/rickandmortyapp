import Combine

public enum SearchModuleEvent {
    case onSubmit(String)
}

public protocol SearchModule: Module {
    var search: Published<String>.Publisher { get }
    var searchSignal: AnyPublisher<SearchModuleEvent, Never> { get }
}
