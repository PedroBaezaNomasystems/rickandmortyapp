//
//  CharacterListView.swift
//  RickAndMorty
//
//  Created by Pedro Juan Baeza Gómez on 15/10/25.
//

import SwiftUI
import Domain
import Combine
import Presentation

struct CharacterListView: View {    
    @StateObject var viewModel: CharacterListViewModel
    
    private let cellRenderer: Renderer
    
    init(router: Routing? = nil, cellRenderer: Renderer) {
        self._viewModel = StateObject(wrappedValue: CharacterListViewModel(router: router))
        self.cellRenderer = cellRenderer
    }
    
    var body: some View {
        VStack {
            List {
                ForEach(viewModel.modules, id: \.uuid) { module in
                    cellRenderer.render(module: module)
                }
                
                if !viewModel.isLoading && !viewModel.modules.isEmpty {
                    ListProgress()
                }
            }
            .searchable(
                text: $viewModel.search,
                placement: .navigationBarDrawer,
                prompt: "character_list_search_placeholder"
            )
            .onSubmit(of: .search) {
                Task {
                    await viewModel.onRefresh()
                }
            }
            .onChange(of: viewModel.search) { oldValue, newValue in
                if newValue.isEmpty {
                    Task {
                        await viewModel.onRefresh()
                    }
                }
            }
            .refreshable {
                Task {
                    await viewModel.onRefresh()
                }
            }
            .overlay {
                if viewModel.modules.isEmpty && !viewModel.isLoading {
                    CharacterListViewEmpty
                }
            }
        }
        .alert(isPresented: $viewModel.isError) {
            CharacterListViewError
        }
        .navigationTitle("character_list_title")
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
    CharacterListView(cellRenderer: CharacterListCellRenderer())
}
