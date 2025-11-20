import Combine
import Domain
import Factory
import SwiftUI

@MainActor
public class CharacterDetailViewModel: ObservableObject {
    @Published public var module: any Module
    
    private var scrollCancellables: [AnyCancellable]
    private var scrollModule: any ScrollModule {
        didSet { initScrollListeners() }
    }
    
    private var loadingCancellables: [AnyCancellable]
    private var loadingModule: any LoadingModule {
        didSet { initLoadingListeners() }
    }
    
    private var errorCancellables: [AnyCancellable]
    private var errorModule: any ErrorModule {
        didSet { initErrorListeners() }
    }
    
    private var characterId: Int
    private var router: Routing?
    
    @Injected(\.getCharacterUseCase)
    private var getCharacterUseCase: (any GetCharacterUseCase)!
    
    public init(characterId: Int, router: Routing?) {
        self.module = CharacterDetailFactory.makeEmptyModule()
        self.scrollCancellables = []
        self.scrollModule = CharacterDetailFactory.makeScrollModule()
        self.loadingCancellables = []
        self.loadingModule = CharacterDetailFactory.makeLoadingModule()
        self.errorCancellables = []
        self.errorModule = CharacterDetailFactory.makeErrorModule()
        self.characterId = characterId
        self.router = router
        
        self.setup()
    }
    
    private func setup() {
        self.initScrollListeners()
        self.initLoadingListeners()
        self.initErrorListeners()
        self.module = makeLoadingModule()
    }
}

private extension CharacterDetailViewModel {
    
    func initScrollListeners() {
        scrollCancellables = []
        
        scrollModule.scrollEventSignal.sink { event in
            switch event {
            case .onAppear: break
            case .onRefresh: self.module = self.makeLoadingModule()
            }
        }
        .store(in: &scrollCancellables)
    }
    
    func initLoadingListeners() {
        loadingCancellables = []
        
        loadingModule.loadingEventSignal.sink { event in
            switch event {
            case .onAppear: self.onAppear()
            }
        }
        .store(in: &loadingCancellables)
    }
    
    func initErrorListeners() {
        errorCancellables = []
        
        errorModule.eventSignal.sink { event in
            switch event {
            case .onRetry: self.module = self.makeLoadingModule()
            }
        }
        .store(in: &errorCancellables)
    }
}

private extension CharacterDetailViewModel {
    
    func onAppear() {
        Task {
            await onFetchData()
        }
    }
    
    func onFetchData() async {
        let result = await getCharacterUseCase.execute(data: characterId)
        switch result {
        case .failure(let error):
            module = makeErrorModule(error: error.localizedDescription)
        case .success(let response):
            module = makeScrollModule(character: response)
        }
    }
}

private extension CharacterDetailViewModel {
    
    func makeErrorModule(error: String) -> any Module {
        errorModule = CharacterDetailFactory.makeErrorModule(error: error)
        return errorModule
    }
    
    func makeLoadingModule() -> any Module {
        loadingModule = CharacterDetailFactory.makeLoadingModule()
        return loadingModule
    }
    
    func makeScrollModule(character: CharacterEntity) -> any Module {
        scrollModule = CharacterDetailFactory.makeScrollModule()
        
        scrollModule.appendModule(CharacterDetailFactory.makeTextModule(text: character.name))
        scrollModule.appendModule(CharacterDetailFactory.makeUrlImageModule(url: character.image))
        scrollModule.appendModule(CharacterDetailFactory.makeTextModule(text: character.status))
        scrollModule.appendModule(CharacterDetailFactory.makeTextModule(text: character.species))
        scrollModule.appendModule(CharacterDetailFactory.makeTextModule(text: character.gender))
        scrollModule.appendModule(CharacterDetailFactory.makeTextModule(text: character.origin))
        scrollModule.appendModule(CharacterDetailFactory.makeTextModule(text: character.location))
        
        return scrollModule
    }
}

