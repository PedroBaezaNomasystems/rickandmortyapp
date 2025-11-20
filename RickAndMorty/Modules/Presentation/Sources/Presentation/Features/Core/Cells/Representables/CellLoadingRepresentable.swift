import Foundation

public protocol CellLoadingRepresentable {
    var infiniteDataSource: CellLoadingDataSource { get }
    func onStart()
}
