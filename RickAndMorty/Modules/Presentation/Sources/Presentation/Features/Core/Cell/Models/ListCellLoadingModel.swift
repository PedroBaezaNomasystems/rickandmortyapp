import Combine
import SwiftUI

public final class ListCellLoadingModel {
    public let uuid: UUID
    public let infiniteDataSource: ListCellLoadingDataSource
    
    public init() {
        uuid = UUID()
        infiniteDataSource = ListCellLoadingDataSource()
    }
}

extension ListCellLoadingModel: ListCellLoadingModule {
    public var isLoading: Published<Bool>.Publisher {
        infiniteDataSource.$isLoading
    }
}

extension ListCellLoadingModel: ListCellLoadingRepresentable {
    public func onStart() {
        infiniteDataSource.isLoading = true
    }
}
