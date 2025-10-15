//
//  CharacterListView.swift
//  RickAndMorty
//
//  Created by Pedro Juan Baeza Gómez on 15/10/25.
//

import SwiftUI
import Presentation

struct CharacterListView: View {
    
    @StateObject var viewModel: CharacterListViewModel
    
    init(router: Routing? = nil) {
        
        _viewModel = StateObject(wrappedValue: CharacterListViewModel(router: router))
    }
    
    var body: some View {
        
        ZStack {
            
            VStack {
                
                Text("Hello Character List View, World!")
                
                Button("Click on character") {
                    viewModel.onClickOnCharacter(index: 0)
                }
            }
            
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
    
    CharacterListView()
}
