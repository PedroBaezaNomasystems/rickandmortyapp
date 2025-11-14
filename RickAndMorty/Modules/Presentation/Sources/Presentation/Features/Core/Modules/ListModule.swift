import Combine

public enum ListModuleEvent {
    case onRefresh
}

public protocol ListModule: Module {
    var eventSignal: AnyPublisher<ListModuleEvent, Never> { get }
    func clearModules()
    func appendModules(_ modules: [any Module])
}
