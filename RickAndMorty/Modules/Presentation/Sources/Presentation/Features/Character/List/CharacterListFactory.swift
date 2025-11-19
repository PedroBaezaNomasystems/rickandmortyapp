import Combine
import Domain

final class CharacterListFactory {
    static func makeEmptyModule() -> any EmptyModule {
        EmptyModel()
    }
    static func makeListModule() -> any ListModule & ListInfiniteModule & SearchModule {
        ListInfiniteSearchModel(searchModel: ListSearchModel(listModel: ListModel(cells: [])))
    }
    
    static func makeErrorModule(error: String = "") -> any ErrorModule {
        ErrorModel(error: error)
    }
}
