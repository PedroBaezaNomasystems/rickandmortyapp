//
//  CharacterDetailViewModelTest.swift
//  Presentation
//
//  Created by Pedro Juan Baeza Gómez on 17/10/25.
//

import XCTest
import Factory
import Domain
@testable import Presentation

@MainActor
final class CharacterDetailViewModelTest: XCTestCase {
    
    private var useCase: GetCharacterUseCaseMock!
    private var sut: CharacterDetailViewModel!
    
    override func setUp() async throws {
        try await super.setUp()
        
        let mock = GetCharacterUseCaseMock()
        useCase = mock
        
        Container.shared.manager.push()
        Container.shared.getCharacterUseCase.register { mock }
        
        sut = CharacterDetailViewModel(router: nil, characterId: "1")
    }
    
    override func tearDown() async throws {
        sut = nil
        useCase = nil
        
        Container.shared.manager.pop()
        try await super.tearDown()
    }
    
    func test_execute_onAppear_whenUseCaseSucceeds() async {
        let expected = CharacterEntityFactory.makeCharacterEntity()
        await useCase.setMockResponse(expected)
        
        XCTAssertFalse(sut.isError)
        XCTAssertNil(sut.character)
        
        await sut.onAppear()
        
        XCTAssertFalse(sut.isError)
        XCTAssertNotNil(sut.character)
        CharacterEntityAssert.assertCharacter(sut.character!, equals: expected)
    }
    
    func test_execute_onAppear_whenUseCaseFails() async {
        await useCase.setMockError(UseCaseError.generic)
        
        XCTAssertFalse(sut.isError)
        XCTAssertNil(sut.character)
        
        await sut.onAppear()
        
        XCTAssertTrue(sut.isError)
        XCTAssertNil(sut.character)
    }
}
