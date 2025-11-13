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

final class CharacterModelUI {
    let uuid: UUID
    let id: Int
    let name: String
    let image: String
    let status: String
    var eventSignal: AnyPublisher<CharacterModuleEvent, Never> {
        eventSubject.eraseToAnyPublisher()
    }
    
    private let eventSubject = PassthroughSubject<CharacterModuleEvent, Never>()
    
    init(id: Int, name: String, image: String, status: String) {
        self.uuid = UUID()
        self.id = id
        self.name = name
        self.image = image
        self.status = status
    }
}

extension CharacterModelUI: CharacterModule {
    
}

extension CharacterModelUI: CharacterViewRepresentable {
    func onTapCharacter() {
        eventSubject.send(.tapCharacter(id))
    }
    
    func onAppearCharacter() {
        eventSubject.send(.appearCharacter(id))
    }
}

public protocol Module: Identifiable {
    var uuid: UUID { get }
}

enum CharacterModuleEvent {
    case tapCharacter(Int)
    case appearCharacter(Int)
}

protocol CharacterModule: Module {
    var id: Int { get }
    var eventSignal: AnyPublisher<CharacterModuleEvent, Never> { get }
}

protocol CharacterViewRepresentable {
    var name: String { get }
    var image: String { get }
    var status: String { get }
    func onTapCharacter() -> Void
    func onAppearCharacter() -> Void
}

struct CharacterListView: View {    
    @StateObject var viewModel: CharacterListV2ViewModel
    
    private let renderer: Renderer
    
    init(router: Routing? = nil, renderer: Renderer) {
        self._viewModel = StateObject(wrappedValue: CharacterListV2ViewModel())
        self.renderer = renderer
    }
    
    var body: some View {
        VStack {
            List {
                ForEach(viewModel.modules, id: \.uuid) { module in
                    renderer.render(module: module)
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
    CharacterListView(renderer: CharacterListRenderer())
}
