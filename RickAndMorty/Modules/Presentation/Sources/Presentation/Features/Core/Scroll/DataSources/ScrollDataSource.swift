import Combine

public final class ScrollDataSource: ObservableObject {
    @Published public var modules: [any Module]
    
    init(modules: [any Module]) {
        self.modules = modules
    }
}
