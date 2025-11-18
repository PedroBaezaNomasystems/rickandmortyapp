import Foundation

public protocol ListInfiniteModule: Module {
    var pages: Int { get set }
    var current: Int { get set }
    func clearLoadingModules()
}
