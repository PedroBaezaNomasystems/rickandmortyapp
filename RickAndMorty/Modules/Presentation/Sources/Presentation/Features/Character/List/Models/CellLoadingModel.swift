import Combine
import Foundation

public final class CellLoadingModel {
    public let uuid: UUID
    @Published private var _isLoading: Bool
    
    init() {
        uuid = UUID()
        _isLoading = false
    }
}

extension CellLoadingModel: CellLoadingModule {
    public var isLoading: Published<Bool>.Publisher {
        $_isLoading
    }
}

extension CellLoadingModel: CellLoadingRepresentable {
    public func start() {
        _isLoading = true
    }
}
