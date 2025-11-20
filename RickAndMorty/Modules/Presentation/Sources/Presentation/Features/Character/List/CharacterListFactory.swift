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

extension CharacterListFactory {
    
    static func makeCellLoadingModule() -> any CellLoadingModule {
        CellLoadingModel()
    }
    
    static func makeCellCharactersModules(_ characters: [CharacterEntity]) -> [any CharacterCellModule] {
        characters.map { character in
            CharacterCellModel(
                id: character.id,
                name: character.name,
                image: character.image,
                status: character.status
            )
        }
    }
}
