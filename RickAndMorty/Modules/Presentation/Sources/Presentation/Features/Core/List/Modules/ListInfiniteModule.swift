import Foundation

public protocol ListInfiniteModule: Module {
    var current: Int { get }
    var thereAreMorePages: Bool { get }
    func prepareFirstPage()
    func prepareNextPage(pages: Int)
    func clearLoadingModules()
}
