import Combine
import SwiftUI

public final class ListModel {
    @Published private var _cells: [any Module]
    
    public let uuid: UUID
    public var eventSignal: AnyPublisher<ListModuleEvent, Never> { eventSubject.eraseToAnyPublisher() }
    
    private let eventSubject = PassthroughSubject<ListModuleEvent, Never>()
    
    public init(cells: [any Module]) {
        _cells = cells
        uuid = UUID()
    }
}

extension ListModel: ListModule {
    public func clearModules() {
        _cells = []
    }
    
    public func appendModules(_ modules: [any Module]) {
        _cells.append(contentsOf: modules)
    }
}

extension ListModel: ListRepresentable {
    public var cells: Published<[any Module]>.Publisher {
        $_cells
    }
    
    public func refresh() {
        eventSubject.send(.onRefresh)
    }
}
