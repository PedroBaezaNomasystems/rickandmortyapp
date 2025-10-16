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
            
            if let character = viewModel.character {
                
                CharacterDetailViewItem(character: character)
            }
            
            if viewModel.isLoading {
                
                FullProgress()
            }
        }
        .alert(isPresented: $viewModel.isError) {
            
            CharacterDetailViewError
        }
        .onAppear {
            
            Task {
                
                await viewModel.onAppear()
            }
        }
        .navigationTitle("character_detail_title")
    }
    
    @ViewBuilder
    private func CharacterDetailViewItem(character: CharacterEntity) -> some View {
        
        VStack {
            
            UrlImage(
                url: character.image,
                width: 60,
                height: 60
            )
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.gray.opacity(0.3), lineWidth: 1))
            
            VStack(alignment: .center) {
                
                Text(character.name)
                    .font(.openSansBold(size: .title))
                
                Text("\(character.status) - \(character.species)")
                    .font(.openSansRegular(size: .label))
            }
            
            Spacer()
        }
    }
    
    private var CharacterDetailViewError: Alert {
        
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
