import Foundation

public protocol ScrollRepresentable {
    var scrollDataSource: ScrollDataSource { get }
    func onAppear()
    func onRefresh()
}
