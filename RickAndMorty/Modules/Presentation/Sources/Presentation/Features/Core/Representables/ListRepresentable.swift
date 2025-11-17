import Foundation

public protocol ListRepresentable {
    var dataSource: ListDataSource { get }
    func refresh()
}
