import Domain
import Factory
import SwiftUI

@MainActor
public class CharacterDetailViewModel: ObservableObject {
    @Published public var isError = false
    @Published public var isLoading = false
    @Published public var character: CharacterEntity? = nil
    
    private var router: Routing?
    private var characterId: Int
    
    @Injected(\.getCharacterUseCase)
    private var getCharacterUseCase: (any GetCharacterUseCase)!
    
    public init(router: Routing?, characterId: Int) {
        self.router = router
        self.characterId = characterId
    }
    
    public func onAppear() async {        
        isLoading = true
        
        let result = await getCharacterUseCase.execute(data: characterId)
        switch result {
        case .success(let response):
            character = response
        case .failure:
            isError = true
        }
        
        isLoading = false
    }
}
