import Combine

public protocol ListCellLoadingModule: Module {
    var isLoading: Published<Bool>.Publisher { get }
}
