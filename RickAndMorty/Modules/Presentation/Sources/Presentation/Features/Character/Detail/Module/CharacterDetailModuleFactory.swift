import Combine
import Domain

final class CharacterDetailModuleFactory {
    static func makeTextModule(text: String) -> any TextModule {
        TextModel(text: text)
    }
}
