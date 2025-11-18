import Combine
import SwiftUI

public final class ListInfiniteModel {
    public var uuid: UUID { listModel.uuid }
    public let listModel: ListModel
    public let listInfiniteDataSource: ListInfiniteDataSource
    
    public init(listModel: ListModel) {
        self.listModel = listModel
        self.listInfiniteDataSource = ListInfiniteDataSource()
    }
}

extension ListInfiniteModel: ListInfiniteModule {
    public var current: Int {
        listInfiniteDataSource.current
    }
    
    public var thereAreMorePages: Bool {
        listInfiniteDataSource.thereAreMorePages
    }
    
    public func prepareFirstPage() {
        listInfiniteDataSource.prepareFirstPage()
    }
    
    public func prepareNextPage(pages: Int) {
        listInfiniteDataSource.prepareNextPage(pages: pages)
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
        listModel.listDataSource.cells.removeAll(where: { $0 is any ListCellLoadingModule })
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
