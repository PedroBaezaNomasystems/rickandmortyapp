import Combine

public final class ErrorDataSource: ObservableObject {
    @Published public var error: String
    
    init(error: String) {
        self.error = error
    }
}
