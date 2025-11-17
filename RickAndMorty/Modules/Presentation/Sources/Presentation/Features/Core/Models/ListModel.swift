import Combine
import SwiftUI

public final class ListModel {
    public let uuid: UUID
    public let dataSource: ListDataSource
    private let eventSubject = PassthroughSubject<ListModuleEvent, Never>()
    
    public init(cells: [any Module]) {
        uuid = UUID()
        dataSource = ListDataSource(cells: cells)
    }
}

extension ListModel: ListModule {
    public var eventSignal: AnyPublisher<ListModuleEvent, Never> {
        eventSubject.eraseToAnyPublisher()
    }
    
    public func clearModules() {
        dataSource.cells = []
    }
    
    public func appendModules(_ modules: [any Module]) {
        dataSource.cells.append(contentsOf: modules)
    }
}

extension ListModel: ListRepresentable {
    public func refresh() {
        eventSubject.send(.onRefresh)
    }
}
