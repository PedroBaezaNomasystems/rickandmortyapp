import Combine

public enum ErrorModuleEvent {
    case onRetry
}

public protocol ErrorModule: Module {
    var eventSignal: AnyPublisher<ErrorModuleEvent, Never> { get }
}
