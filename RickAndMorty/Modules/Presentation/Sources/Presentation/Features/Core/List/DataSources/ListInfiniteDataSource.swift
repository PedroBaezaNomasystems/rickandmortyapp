import Combine

public final class ListInfiniteDataSource {
    public var thereAreMorePages: Bool {
        self.current <= self.pages
    }
    
    public private(set) var pages: Int
    public private(set) var current: Int
    
    init() {
        self.pages = 1
        self.current = 1
    }
    
    public func prepareFirstPage() {
        self.pages = 1
        self.current = 1
    }
    
    public func prepareNextPage(pages: Int) {
        self.pages = pages
        self.current += 1
    }
}
