import Combine

public protocol CellLoadingModule: Module {
    var isLoading: Published<Bool>.Publisher { get }
}
