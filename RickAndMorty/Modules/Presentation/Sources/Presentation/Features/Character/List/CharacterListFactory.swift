import Combine
import Domain

final class CharacterListFactory {
    static func makeListModule() -> any Module {
        ListInfiniteSearchModel(searchModel: ListSearchModel(listModel: ListModel(cells: [])))
    }
    
    static func makeErrorModule(error: String) -> any Module {
        ErrorModel(error: error)
    }
}
