import Combine

public final class ListCellLoadingDataSource: ObservableObject {
    @Published public var isLoading: Bool
    
    init() {
        self.isLoading = false
    }
}
