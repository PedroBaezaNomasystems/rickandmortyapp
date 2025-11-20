import Combine
import SwiftUI

public final class CharacterCellModel {
    public let uuid: UUID
    public let id: Int
    public let name: String
    public let image: String
    public let status: String
    private let eventSubject = PassthroughSubject<CharacterCellModuleEvent, Never>()
    
    public init(id: Int, name: String, image: String, status: String) {
        self.uuid = UUID()
        self.id = id
        self.name = name
        self.image = image
        self.status = status
    }
}

extension CharacterCellModel: CharacterCellModule {
    public var eventSignal: AnyPublisher<CharacterCellModuleEvent, Never> {
        eventSubject.eraseToAnyPublisher()
    }
}

extension CharacterCellModel: CharacterCellRepresentable {
    public func onTapCharacter() {
        eventSubject.send(.onTapCharacter(id))
    }
}
