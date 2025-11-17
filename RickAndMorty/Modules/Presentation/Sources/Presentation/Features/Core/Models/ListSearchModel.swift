import Combine
import SwiftUI

public final class ListSearchModel {
    
    public var uuid: UUID {
        model.uuid
    }
    public let model: ListModel
    public let searchDataSource: SearchDataSource
    private let eventSubject = PassthroughSubject<SearchModuleEvent, Never>()
    
    public init(model: ListModel) {
        self.model = model
        self.searchDataSource = SearchDataSource(search: "")
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
    public var eventSignal: AnyPublisher<ListModuleEvent, Never> {
        model.eventSignal
    }
    
    public func clearModules() {
        model.clearModules()
    }
    
    public func appendModules(_ modules: [any Module]) {
        model.appendModules(modules)
    }
}

extension ListSearchModel: ListRepresentable {
    public var listDataSource: ListDataSource {
        model.listDataSource
    }
    public func refresh() {
        model.refresh()
    }
}
