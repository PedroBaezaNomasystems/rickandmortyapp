import Combine
import SwiftUI

public final class ListInfiniteModel {
    public var uuid: UUID { listModel.uuid }
    public let listModel: ListModel
    
    public init(listModel: ListModel) {
        self.listModel = listModel
    }
}

extension ListInfiniteModel: ListInfiniteModule {
    public func clearLoadingModules() {
        listModel.listDataSource.cells.removeAll(where: { $0 is any CellLoadingModule })
    }
}

extension ListInfiniteModel: ListInfiniteRepresentable { }

extension ListInfiniteModel: ListModule {
    public var listEventSignal: AnyPublisher<ListModuleEvent, Never> {
        listModel.listEventSignal
    }
    
    public func clearModules() {
        listModel.clearModules()
    }
    
    public func appendModules(_ modules: [any Module]) {
        listModel.appendModules(modules)
    }
}

extension ListInfiniteModel: ListRepresentable {
    public var listDataSource: ListDataSource {
        listModel.listDataSource
    }
    public func onRefresh() {
        listModel.onRefresh()
    }
}
