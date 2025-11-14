import Combine
import SwiftUI

public final class CharacterListCellModel {
    public let uuid: UUID
    public let id: Int
    public let name: String
    public let image: String
    public let status: String
    public var eventSignal: AnyPublisher<CharacterListCellModuleEvent, Never> {
        eventSubject.eraseToAnyPublisher()
    }
    
    private let eventSubject = PassthroughSubject<CharacterListCellModuleEvent, Never>()
    
    public init(id: Int, name: String, image: String, status: String) {
        self.uuid = UUID()
        self.id = id
        self.name = name
        self.image = image
        self.status = status
    }
}

extension CharacterListCellModel: CharacterListCellModule { }

extension CharacterListCellModel: CharacterListCellRepresentable {
    public func onTapCharacter() {
        eventSubject.send(.tapCharacter(id))
    }
}

