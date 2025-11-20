import Combine
import SwiftUI

public final class LoadingModel {
    public var uuid: UUID
    private let eventSubject = PassthroughSubject<LoadingModuleEvent, Never>()
    
    public init() {
        self.uuid = UUID()
    }
}

extension LoadingModel: LoadingModule {
    public var loadingEventSignal: AnyPublisher<LoadingModuleEvent, Never> {
        eventSubject.eraseToAnyPublisher()
    }
}
extension LoadingModel: LoadingRepresentable {
    public func onAppear() {
        eventSubject.send(.onAppear)
    }
}
