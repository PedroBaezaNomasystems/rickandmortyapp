import Combine

public enum LoadingModuleEvent {
    case onAppear
}

public protocol LoadingModule: Module {
    var loadingEventSignal: AnyPublisher<LoadingModuleEvent, Never> { get }
}
