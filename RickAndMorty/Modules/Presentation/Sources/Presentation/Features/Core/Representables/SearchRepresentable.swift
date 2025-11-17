import Foundation

public protocol SearchRepresentable {
    var searchDataSource: SearchDataSource { get }
    func onSubmit()
}
