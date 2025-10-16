//
//  CharacterListView.swift
//  RickAndMorty
//
//  Created by Pedro Juan Baeza Gómez on 15/10/25.
//

import SwiftUI
import Domain
import Presentation

struct CharacterListView: View {
    
    @StateObject var viewModel: CharacterListViewModel
    
    init(router: Routing? = nil) {
        
        _viewModel = StateObject(wrappedValue: CharacterListViewModel(router: router))
    }
    
    var body: some View {
        
        List {
            
            ForEach(viewModel.characters, id: \.id) { character in
                
                CharacterListViewItem(character: character)
            }
            
            if !viewModel.isLoading && !viewModel.characters.isEmpty {
                
                ListProgress()
            }
        }
        .refreshable {
            
            Task {
                
                await viewModel.onRefresh()
            }
        }
        .overlay {
            
            if viewModel.characters.isEmpty && !viewModel.isLoading {
                
                CharacterListViewEmpty
            }
        }
        .alert(isPresented: $viewModel.isError) {
            
            CharacterListViewError
        }
        .navigationTitle("character_list_title")
    }
    
    @ViewBuilder
    private func CharacterListViewItem(character: CharacterEntity) -> some View {
        
        HStack {
            
            UrlImage(
                url: character.image,
                width: 60,
                height: 60
            )
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.gray.opacity(0.3), lineWidth: 1))
            
            VStack(alignment: .leading) {
                
                Text(character.name)
                    .font(.openSansBold(size: .title))
                
                Text("\(character.status) - \(character.species)")
                    .font(.openSansRegular(size: .label))
            }
        }
        .onTapGesture {
            
            viewModel.onClickOnCharacter(id: character.id)
        }
        .onAppear {
            
            if character.id == viewModel.characters.last?.id {
                
                Task {
                    
                    await viewModel.onRequestMoreCharacters()
                }
            }
        }
    }
    
    @ViewBuilder
    private var CharacterListViewEmpty: some View {
        ContentUnavailableView(
            "character_list_empty_list",
            systemImage: SystemIcon.persons.rawValue,
            description: Text("common_pull_to_refresh")
        )
    }
    
    private var CharacterListViewError: Alert {
        
        Alert(
            title: Text("character_list_error_title"),
            message: Text("character_list_error_message"),
            primaryButton: .default(Text("common_ok")),
            secondaryButton: .cancel()
        )
    }
}

#Preview {
    
    CharacterListView()
}
