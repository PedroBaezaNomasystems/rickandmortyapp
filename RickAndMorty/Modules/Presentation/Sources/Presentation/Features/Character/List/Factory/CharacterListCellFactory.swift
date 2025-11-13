import Combine
import Domain

final class CharacterListCellFactory {
    
    static func makeModules(characters: [CharacterEntity], onTap: @escaping (Int) -> Void, onAppear: @escaping (Int) -> Void, cancellables: inout [AnyCancellable]) -> [any Module] {
        let modules = characters.map { character in
            CharacterListCellModel(
                id: character.id,
                name: character.name,
                image: character.image,
                status: character.status
            )
        }
        
        modules.forEach { module in
            module.eventSignal.sink { event in
                switch event {
                case .tapCharacter(let id): onTap(id)
                case .appearCharacter(let id): onAppear(id)
                }
            }
            .store(in: &cancellables)
        }
        
        return modules
    }
}
