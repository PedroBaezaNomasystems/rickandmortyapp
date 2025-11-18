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
    public var search: String {
        searchDataSource.search
    }
    
    public var searchPublisher: Published<String>.Publisher {
        searchDataSource.$search
    }
    
    public var searchEventSignal: AnyPublisher<SearchModuleEvent, Never> {
        eventSubject.eraseToAnyPublisher()
    }
}

extension ListSearchModel: SearchRepresentable {
    public func onSubmit() {
        eventSubject.send(.onSubmit)
    }
}

extension ListSearchModel: ListModule {
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

extension ListSearchModel: ListRepresentable {
    public var listDataSource: ListDataSource {
        listModel.listDataSource
    }
    public func onRefresh() {
        listModel.onRefresh()
    }
}
