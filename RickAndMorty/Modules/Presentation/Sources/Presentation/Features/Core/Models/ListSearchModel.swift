import Combine
import SwiftUI

public final class ListSearchModel {
    public var uuid: UUID { listModel.uuid }
    public let listModel: ListModel
    public let searchDataSource: SearchDataSource
    private let eventSubject = PassthroughSubject<SearchModuleEvent, Never>()
    
    public init(listModel: ListModel) {
        self.listModel = listModel
        self.searchDataSource = SearchDataSource()
    }
}

extension ListSearchModel: SearchModule {
    public var searchSignal: AnyPublisher<SearchModuleEvent, Never> {
        eventSubject.eraseToAnyPublisher()
    }
    
    public var search: Published<String>.Publisher {
        searchDataSource.$search
    }
}

extension ListSearchModel: SearchRepresentable {
    public func onSubmit() {
        eventSubject.send(.onSubmit(searchDataSource.search))
    }
}

extension ListSearchModel: ListModule {
    public var listSignal: AnyPublisher<ListModuleEvent, Never> {
        listModel.listSignal
    }
    
    public func clearModules() {
        listModel.clearModules()
    }
    
    public func appendModules(_ modules: [any Module]) {
        listModel.appendModules(modules)
    }
}

extension ListSearchModel: ListRepresentable {
    public var listDataSource: ListDataSource {
        listModel.listDataSource
    }
    public func onRefresh() {
        listModel.onRefresh()
    }
}
