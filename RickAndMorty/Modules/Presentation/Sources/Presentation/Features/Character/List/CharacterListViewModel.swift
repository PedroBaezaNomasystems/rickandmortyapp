//
//  CharacterListViewModel.swift
//  Presentation
//
//  Created by Pedro Juan Baeza Gómez on 15/10/25.
//

import SwiftUI
import Domain
import Factory

@MainActor
public class CharacterListViewModel: ObservableObject {
    
    @Published public var isError = false
    @Published public var isLoading = false
    @Published public var characters: [CharacterEntity] = []
    
    private var router: Routing?
    
    @Injected(\.getCharacterUseCase)
    private var getCharacterUseCase: (any GetCharacterUseCase)!
    
    public init(router: Routing?) {
        
        self.router = router
    }
    
    public func onAppear() async {
        
        isLoading = true
        
        let result = await getCharacterUseCase.execute(data: "2")
        switch result {
        case .success:
            isError = false
        case .failure:
            isError = true
        }
        
        isLoading = false
    }
    
    public func onClickOnCharacter(index: Int) {
        
        router?.navigate(to: .character("1"))
    }
}
