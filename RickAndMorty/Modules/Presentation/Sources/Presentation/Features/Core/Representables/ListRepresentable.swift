import Foundation

public protocol ListRepresentable {
    var listDataSource: ListDataSource { get }
    func refresh()
}
