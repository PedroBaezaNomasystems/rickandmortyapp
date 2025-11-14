import Combine
import SwiftUI

public final class ListModel {
    @Published public var cells: [any Module]
    
    public var uuid: UUID
    public var cellsPublisher: Published<[any Module]>.Publisher { $cells }
    public var eventSignal: AnyPublisher<ListModuleEvent, Never> { eventSubject.eraseToAnyPublisher() }
    
    private let eventSubject = PassthroughSubject<ListModuleEvent, Never>()
    
    public init(cells: [any Module]) {
        self.uuid = UUID()
        self.cells = cells
    }
}

extension ListModel: ListModule {
    public func clearModules() {
        cells = []
    }
    
    public func appendModules(_ modules: [any Module]) {
        cells.append(contentsOf: modules)
    }
}

extension ListModel: ListRepresentable {
    public func refresh() {
        eventSubject.send(.onRefresh)
    }
}
