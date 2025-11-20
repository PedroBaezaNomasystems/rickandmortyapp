import Combine
import Domain

final class CharacterDetailFactory {
    static func makeEmptyModule() -> any EmptyModule {
        EmptyModel()
    }
    
    static func makeScrollModule(modules: [any Module] = []) -> any ScrollModule {
        ScrollModel(modules: modules)
    }
    
    static func makeErrorModule(error: String = "") -> any ErrorModule {
        ErrorModel(error: error)
    }
}

extension CharacterDetailFactory {
    
    static func makeTextModule(text: String) -> any TextModule {
        TextModel(text: text)
    }
}
