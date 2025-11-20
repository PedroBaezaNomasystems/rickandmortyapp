import Combine
import SwiftUI

public final class CellLoadingModel {
    public let uuid: UUID
    public let infiniteDataSource: CellLoadingDataSource
    
    public init() {
        uuid = UUID()
        infiniteDataSource = CellLoadingDataSource()
    }
}

extension CellLoadingModel: CellLoadingModule {
    public var isLoading: Published<Bool>.Publisher {
        infiniteDataSource.$isLoading
    }
}

extension CellLoadingModel: CellLoadingRepresentable {
    public func onStart() {
        infiniteDataSource.isLoading = true
    }
}
