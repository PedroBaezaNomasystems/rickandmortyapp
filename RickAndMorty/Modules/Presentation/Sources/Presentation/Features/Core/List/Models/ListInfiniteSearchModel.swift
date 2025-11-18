import Combine
import SwiftUI

public final class ListInfiniteSearchModel {
    public var uuid: UUID { searchModel.uuid }
    public let searchModel: ListSearchModel
    public let listInfiniteDataSource: ListInfiniteDataSource
    
    public init(searchModel: ListSearchModel) {
        self.searchModel = searchModel
        self.listInfiniteDataSource = ListInfiniteDataSource()
    }
}

extension ListInfiniteSearchModel: ListInfiniteModule {
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

extension ListInfiniteSearchModel: ListInfiniteRepresentable {
    
}

extension ListInfiniteSearchModel: SearchModule {
    public var search: String {
        searchModel.search
    }
    
    public var searchPublisher: Published<String>.Publisher {
        searchModel.searchPublisher
    }
    
    public var searchEventSignal: AnyPublisher<SearchModuleEvent, Never> {
        searchModel.searchEventSignal
    }
}

extension ListInfiniteSearchModel: SearchRepresentable {
    public var searchDataSource: SearchDataSource {
        searchModel.searchDataSource
    }
    
    public func onSubmit() {
        searchModel.onSubmit()
    }
}

extension ListInfiniteSearchModel: ListModule {
    public var listEventSignal: AnyPublisher<ListModuleEvent, Never> {
        searchModel.listEventSignal
    }
    
    public func clearModules() {
        searchModel.clearModules()
    }
    
    public func appendModules(_ modules: [any Module]) {
        searchModel.listDataSource.cells.removeAll(where: { $0 is any ListCellLoadingModule })
        searchModel.appendModules(modules)
    }
}

extension ListInfiniteSearchModel: ListRepresentable {
    public var listDataSource: ListDataSource {
        searchModel.listDataSource
    }
    public func onRefresh() {
        searchModel.onRefresh()
    }
}
