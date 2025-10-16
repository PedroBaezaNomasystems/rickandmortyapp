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
                VStack(alignment: .leading) {
                    Text(character.name)
                        .font(.headline)
                    Text("\(character.status) - \(character.species)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
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
                ContentUnavailableView(
                    "No Characters",
                    systemImage: "person.2.slash",
                    description: Text("Pull to refresh")
                )
            }
        }
        .navigationTitle("Characters")
        .alert(isPresented: $viewModel.isError) {
            errorAlert
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
    
    CharacterListView()
}
