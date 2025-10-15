//
//  Container+AutoRegister.swift
//  RickAndMorty
//
//  Created by Pedro Juan Baeza Gómez on 15/10/25.
//

import Foundation
import Factory
import Data
import Domain

extension Container: @retroactive AutoRegistering {
    
    public func autoRegister() {
        
        dataRegister()
        domainRegister()
    }
    
    private func dataRegister() {
        
        guard let baseURL = Config.baseURL else { return }
        
        networkService.register {
            NetworkServiceImpl(baseUrl: baseURL)
        }
    }
    
    private func domainRegister() {
        
        characterRepository.register {
            CharacterRepositoryImpl()
        }
        
        getCharacterUseCase.register {
            GetCharacterUseCaseImpl()
        }
    }
}
