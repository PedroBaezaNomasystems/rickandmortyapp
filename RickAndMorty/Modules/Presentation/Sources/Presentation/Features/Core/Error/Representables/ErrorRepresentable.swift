import Foundation

public protocol ErrorRepresentable {
    var errorDataSource: ErrorDataSource { get }
    func onRetry()
}
