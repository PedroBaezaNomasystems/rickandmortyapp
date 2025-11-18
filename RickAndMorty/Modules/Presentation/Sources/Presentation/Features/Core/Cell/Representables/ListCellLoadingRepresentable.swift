import Foundation

public protocol ListCellLoadingRepresentable {
    var infiniteDataSource: ListCellLoadingDataSource { get }
    func onStart()
}
