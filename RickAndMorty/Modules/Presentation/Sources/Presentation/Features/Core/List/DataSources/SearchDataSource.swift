import Combine

public final class SearchDataSource: ObservableObject {
    @Published public var search: String
    
    init() {
        self.search = ""
    }
}
