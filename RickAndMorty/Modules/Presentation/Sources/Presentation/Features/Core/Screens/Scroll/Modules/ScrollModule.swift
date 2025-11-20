import Combine

public enum ScrollModuleEvent {
    case onAppear
    case onRefresh
}

public protocol ScrollModule: Module {
    var scrollEventSignal: AnyPublisher<ScrollModuleEvent, Never> { get }
    func clearModules()
    func appendModule(_ module: any Module)
}
