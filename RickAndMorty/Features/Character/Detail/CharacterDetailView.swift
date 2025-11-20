import SwiftUI
import Domain
import Presentation

struct CharacterDetailView: View {
    @StateObject var viewModel: CharacterDetailViewModel
    
    private let renderer: Renderer
    
    init(renderer: Renderer, characterId: Int = 1, router: Routing? = nil) {
        self._viewModel = StateObject(wrappedValue: CharacterDetailViewModel(characterId: characterId, router: router))
        self.renderer = renderer
    }
    
    var body: some View {
        renderer.render(module: viewModel.module)
            .navigationTitle("character_detail_title")
    }
}

/*struct CharacterDetailView: View {
    
    @StateObject var viewModel: CharacterDetailViewModel
    
    init(router: Routing? = nil, characterId: Int = 1) {
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
        ScrollView {
            VStack {
                UrlImage(url: character.image)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(.top, .small)
                
                VStack(alignment: .center, spacing: .small) {
                    Text(character.name)
                        .font(.openSansBold(size: .headline))
                        .padding(.vertical, .small)
                    
                    VStack {
                        CharacterDetailViewElement("character_detail_status_field", character.status)
                        CharacterDetailViewElement("character_detail_specie_field", character.species)
                        CharacterDetailViewElement("character_detail_gender_field", character.gender)
                        CharacterDetailViewElement("character_detail_origin_field", character.origin)
                        CharacterDetailViewElement("character_detail_location_field", character.location)
                    }
                }
            }            
            .padding(.horizontal, .large)
        }
    }
    
    @ViewBuilder
    private func CharacterDetailViewElement(_ key: String, _ value: String) -> some View {
        VStack {
            HStack(alignment: .center) {
                Text(LocalizedStringKey(key))
                    .font(.openSansRegular(size: .title))
                
                Spacer()
                
                Text(value)
                    .font(.openSansLight(size: .title))
            }
            
            Divider()
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
}*/
