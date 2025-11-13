import Combine
import SwiftUI

public final class CharacterListModel {
    public let uuid: UUID
    public var cells: [any Module]
    public var eventSignal: AnyPublisher<CharacterListModuleEvent, Never> {
        eventSubject.eraseToAnyPublisher()
    }
    
    private let eventSubject = PassthroughSubject<CharacterListModuleEvent, Never>()
    
    public init(cells: [any Module]) {
        self.uuid = UUID()
        self.cells = cells
    }
}

extension CharacterListModel: CharacterListModule { }

extension CharacterListModel: CharacterListRepresentable {
    public func onRefresh(search: String) {
        eventSubject.send(.onRefresh(search))
    }
}

