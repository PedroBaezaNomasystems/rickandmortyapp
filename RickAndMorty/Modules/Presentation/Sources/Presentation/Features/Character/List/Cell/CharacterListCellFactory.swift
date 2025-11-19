import Combine
import Domain

final class CharacterListCellFactory {
    static func makeLoadingModule() -> any ListCellLoadingModule {
        ListCellLoadingModel()
    }
    
    static func makeCharactersModules(_ characters: [CharacterEntity]) -> [any CharacterListCellModule] {
        characters.map { character in
            CharacterListCellModel(
                id: character.id,
                name: character.name,
                image: character.image,
                status: character.status
            )
        }
    }
}
