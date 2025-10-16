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
    
    @Injected(\.getCharactersUseCase)
    private var getCharactersUseCase: (any GetCharactersUseCase)!
    
    public init(router: Routing?) {
        
        self.router = router
    }
    
    public func onAppear() async {
        
        isLoading = true
        
        let result = await getCharactersUseCase.execute()
        switch result {
        case .success(let response):
            characters = response.results
        case .failure:
            isError = true
        }
        
        isLoading = false
    }
    
    public func onClickOnCharacter(index: Int) {
        
        router?.navigate(to: .character("1"))
    }
}
