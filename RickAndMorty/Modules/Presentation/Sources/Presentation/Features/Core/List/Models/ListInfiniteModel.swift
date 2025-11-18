import Combine
import SwiftUI

public final class ListInfiniteModel {
    public var uuid: UUID { listModel.uuid }
    public let listModel: ListModel
    public var pages: Int
    public var current: Int
    
    public init(listModel: ListModel) {
        self.listModel = listModel
        self.pages = 1
        self.current = 1
    }
    
    private func clearLoadingModules() {
        listModel.listDataSource.cells.removeAll(where: { $0 is any ListCellLoadingModule })
    }
}

extension ListInfiniteModel: ListInfiniteModule {
    public var thereAreMorePages: Bool {
        current < pages
    }
    
    public func prepareFirstPage() {
        pages = 1
        current = 1
        clearModules()
    }
    public func prepareNextPage() {
        current += 1
        clearLoadingModules()
    }
}

extension ListInfiniteModel: ListInfiniteRepresentable {
    
}

extension ListInfiniteModel: ListModule {
    public var listEventSignal: AnyPublisher<ListModuleEvent, Never> {
        listModel.listEventSignal
    }
    
    public func clearModules() {
        listModel.clearModules()
    }
    
    public func appendModules(_ modules: [any Module]) {
        clearLoadingModules()
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
