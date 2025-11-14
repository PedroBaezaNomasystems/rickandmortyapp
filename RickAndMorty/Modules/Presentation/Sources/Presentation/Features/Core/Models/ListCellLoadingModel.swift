import Combine
import Foundation

public final class ListCellLoadingModel {
    @Published public var _isLoading: Bool
    
    public let uuid: UUID
    
    init() {
        _isLoading = false
        uuid = UUID()
    }
}

extension ListCellLoadingModel: ListCellLoadingModule {
    public var isLoading: Published<Bool>.Publisher {
        $_isLoading
    }
}

extension ListCellLoadingModel: ListCellLoadingRepresentable {
    public func start() {
        _isLoading = true
    }
}
