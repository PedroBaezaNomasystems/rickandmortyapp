import Combine
import SwiftUI

public final class ListInfiniteSearchModel {
    public var uuid: UUID { searchModel.uuid }
    public let searchModel: ListSearchModel
    public var pages: Int
    public var current: Int
    
    public init(pages: Int, current: Int, searchModel: ListSearchModel) {
        self.searchModel = searchModel
        self.pages = pages
        self.current = current
    }
}

extension ListInfiniteSearchModel: ListInfiniteModule {
    public func clearLoadingModules() {
        searchModel.listDataSource.cells.removeAll(where: { $0 is any ListCellLoadingModule })
    }
}

extension ListInfiniteSearchModel: ListInfiniteRepresentable {
    
}

extension ListInfiniteSearchModel: SearchModule {
    public var searchSignal: AnyPublisher<SearchModuleEvent, Never> {
        searchModel.searchSignal
    }
    
    public var search: Published<String>.Publisher {
        searchModel.search
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
    public var listSignal: AnyPublisher<ListModuleEvent, Never> {
        searchModel.listSignal
    }
    
    public func clearModules() {
        searchModel.clearModules()
    }
    
    public func appendModules(_ modules: [any Module]) {
        clearLoadingModules()
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
