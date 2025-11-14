public protocol Searchable {
    var search: String { get set }
    func onSearch()
}
