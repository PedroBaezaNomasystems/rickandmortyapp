import Combine
import SwiftUI

public final class ListModel {
    public let uuid: UUID
    public let listDataSource: ListDataSource
    private let eventSubject = PassthroughSubject<ListModuleEvent, Never>()
    
    public init(cells: [any Module]) {
        uuid = UUID()
        listDataSource = ListDataSource(cells: cells)
    }
}

extension ListModel: ListModule {
    public var listEventSignal: AnyPublisher<ListModuleEvent, Never> {
        eventSubject.eraseToAnyPublisher()
    }
    
    public func clearModules() {
        listDataSource.cells = []
    }
    
    public func appendModules(_ modules: [any Module]) {
        listDataSource.cells.append(contentsOf: modules)
    }
}

extension ListModel: ListRepresentable {
    public func onRefresh() {
        eventSubject.send(.onRefresh)
    }
}
