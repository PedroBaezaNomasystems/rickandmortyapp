import Combine
import SwiftUI

public final class ScrollModel {
    public let uuid: UUID
    public let scrollDataSource: ScrollDataSource
    private let eventSubject = PassthroughSubject<ScrollModuleEvent, Never>()
    
    public init(modules: [any Module]) {
        uuid = UUID()
        scrollDataSource = ScrollDataSource(modules: modules)
    }
}

extension ScrollModel: ScrollModule {
    public var scrollEventSignal: AnyPublisher<ScrollModuleEvent, Never> {
        eventSubject.eraseToAnyPublisher()
    }
    
    public func clearModules() {
        scrollDataSource.modules = []
    }
    
    public func appendModule(_ module: any Module) {
        scrollDataSource.modules.append(module)
    }
}

extension ScrollModel: ScrollRepresentable {
    public func onAppear() {
        eventSubject.send(.onAppear)
    }
    
    public func onRefresh() {
        eventSubject.send(.onRefresh)
    }
}
