import Combine

public final class CellLoadingDataSource: ObservableObject {
    @Published public var isLoading: Bool
    
    init() {
        self.isLoading = false
    }
}
