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
                .font(.openSansBold(size: .title))
                .padding(.all, .large)
            
            if viewModel.isLoading {
                FullProgress()
            }
        }
        .navigationTitle("character_detail_title")
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
            title: Text("character_detail_error_title"),
            message: Text("character_detail_error_message"),
            primaryButton: .default(Text("common_ok")),
            secondaryButton: .cancel()
        )
    }
}

#Preview {
    
    CharacterDetailView()
}
