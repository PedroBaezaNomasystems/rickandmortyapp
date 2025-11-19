extension CharacterListViewModel {
    var listModule: (any ListModule & ListInfiniteModule & SearchModule)? {
        module as? (any ListModule & ListInfiniteModule & SearchModule)
    }
    
    var errorModule: (any ErrorModule)? {
        module as? (any ErrorModule)
    }
}
