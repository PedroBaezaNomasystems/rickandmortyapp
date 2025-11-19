import Combine
import SwiftUI

public final class CharacterListCellModel {
    public let uuid: UUID
    public let id: Int
    public let name: String
    public let image: String
    public let status: String
    private let eventSubject = PassthroughSubject<CharacterListCellModuleEvent, Never>()
    
    public init(id: Int, name: String, image: String, status: String) {
        self.uuid = UUID()
        self.id = id
        self.name = name
        self.image = image
        self.status = status
    }
}

extension CharacterListCellModel: CharacterListCellModule {
    public var eventSignal: AnyPublisher<CharacterListCellModuleEvent, Never> {
        eventSubject.eraseToAnyPublisher()
    }
}

extension CharacterListCellModel: CharacterListCellRepresentable {
    public func onTapCharacter() {
        eventSubject.send(.onTapCharacter(id))
    }
}
