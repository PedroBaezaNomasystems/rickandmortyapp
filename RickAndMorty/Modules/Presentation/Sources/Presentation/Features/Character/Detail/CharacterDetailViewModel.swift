//
//  CharacterViewModel.swift
//  Presentation
//
//  Created by Pedro Juan Baeza Gómez on 15/10/25.
//

import SwiftUI
import Domain
import Factory

@MainActor
public class CharacterDetailViewModel: ObservableObject {
    
    @Published public var isError = false
    @Published public var isLoading = false
    @Published public var character: CharacterEntity? = nil
    
    private var router: Routing?
    private var characterId: String
    
    @Injected(\.getCharacterUseCase)
    private var getCharacterUseCase: (any GetCharacterUseCase)!
    
    public init(router: Routing?, characterId: String) {
        
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
