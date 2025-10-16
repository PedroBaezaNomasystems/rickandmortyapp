//
//  CharacterDetailView.swift
//  RickAndMorty
//
//  Created by Pedro Juan Baeza Gómez on 15/10/25.
//

import SwiftUI
import Domain
import Presentation

struct CharacterDetailView: View {
    
    @StateObject var viewModel: CharacterDetailViewModel
    
    init(router: Routing? = nil, characterId: String = "1") {
        
        _viewModel = StateObject(wrappedValue: CharacterDetailViewModel(router: router, characterId: characterId))
    }
    
    var body: some View {
        
        ZStack {
            
            Text(viewModel.character?.name ?? "")
            
            if viewModel.isLoading {
                
                FullProgress()
            }
        }
        .navigationTitle("Character")
        .alert(isPresented: $viewModel.isError) {
            errorAlert
        }
        .onAppear {
            Task {
                await viewModel.onAppear()
            }
        }
    }
    
    private var errorAlert: Alert {
        
        Alert(
            title: Text("error_title"),
            message: Text("error_message"),
            primaryButton: .default(Text("OK")),
            secondaryButton: .cancel()
        )
    }
}

#Preview {
    
    CharacterDetailView()
}
