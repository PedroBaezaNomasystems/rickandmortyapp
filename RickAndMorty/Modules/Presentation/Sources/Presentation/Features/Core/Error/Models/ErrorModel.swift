import Combine
import SwiftUI

public final class ErrorModel {
    public var uuid: UUID
    public let errorDataSource: ErrorDataSource
    private let eventSubject = PassthroughSubject<ErrorModuleEvent, Never>()
    
    public init(error: String) {
        self.uuid = UUID()
        self.errorDataSource = ErrorDataSource(error: error)
    }
}

extension ErrorModel: ErrorModule {
    public var eventSignal: AnyPublisher<ErrorModuleEvent, Never> {
        eventSubject.eraseToAnyPublisher()
    }
}

extension ErrorModel: ErrorRepresentable {
    public func onRetry() {
        eventSubject.send(.onRetry)
    }
}
