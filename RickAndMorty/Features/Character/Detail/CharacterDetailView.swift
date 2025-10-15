//
//  CharacterDetailView.swift
//  RickAndMorty
//
//  Created by Pedro Juan Baeza Gómez on 15/10/25.
//

import SwiftUI
import Presentation

struct CharacterDetailView: View {
    @StateObject var viewModel: CharacterDetailViewModel
    
    init(router: Routing? = nil, characterId: String? = nil) {
        
        _viewModel = StateObject(wrappedValue: CharacterDetailViewModel(router: router, characterId: characterId))
    }
    
    var body: some View {
        
        ZStack {
            
            Text("Hello, World!")
            
            if viewModel.isLoading {
                
                FullProgress()
            }
        }
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
            title: Text("login_title"),
            message: Text("login_error"),
            primaryButton: .default(Text("OK")),
            secondaryButton: .cancel()
        )
    }
}

#Preview {
    
    CharacterDetailView()
}
