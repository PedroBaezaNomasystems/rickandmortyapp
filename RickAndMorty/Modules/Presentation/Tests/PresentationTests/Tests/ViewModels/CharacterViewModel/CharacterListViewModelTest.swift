//
//  CharacterListViewModelTest.swift
//  Presentation
//
//  Created by Pedro Juan Baeza Gómez on 17/10/25.
//

import XCTest
import Factory
import Domain
@testable import Presentation

@MainActor
final class CharacterListViewModelTest: XCTestCase {
    
    private var useCase: GetCharactersUseCaseMock!
    private var sut: CharacterListViewModel!
    
    override func setUp() async throws {
        try await super.setUp()
        
        let mock = GetCharactersUseCaseMock()
        useCase = mock
        
        Container.shared.manager.push()
        Container.shared.getCharactersUseCase.register { mock }
        
        sut = CharacterListViewModel(router: nil)
    }
    
    override func tearDown() async throws {
        sut = nil
        useCase = nil
        
        Container.shared.manager.pop()
        try await super.tearDown()
    }
    
    func test_execute_onRefresh_whenUseCaseSucceeds() async {
        let expected = CharacterEntityFactory.makeListEntity()
        await useCase.setMockResponse(expected)
        
        /*XCTAssertFalse(sut.isError)
        XCTAssertTrue(sut.characters.isEmpty)
        
        await sut.onRefresh()
        
        XCTAssertFalse(sut.isError)
        XCTAssertFalse(sut.characters.isEmpty)
        XCTAssert(sut.characters.count == 1)
        CharacterEntityAssert.assertCharacter(sut.characters[0], equals: expected.results[0])*/
    }
    
    func test_execute_onRefresh_whenUseCaseFails() async {
        await useCase.setMockError(UseCaseError.generic)
        
        /*XCTAssertFalse(sut.isError)
        XCTAssertTrue(sut.characters.isEmpty)
        
        await sut.onRefresh()
        
        XCTAssertTrue(sut.isError)
        XCTAssertTrue(sut.characters.isEmpty)*/
    }
    
    func test_execute_onRequestMoreCharacters_whenTwoPages() async {
        let expected = CharacterEntityFactory.makeListTwoPagesEntity()
        await useCase.setMockResponse(expected)
        
        /*XCTAssertFalse(sut.isError)
        XCTAssertTrue(sut.characters.isEmpty)
        
        await sut.onRefresh()
        
        XCTAssertFalse(sut.isError)
        XCTAssertFalse(sut.characters.isEmpty)
        XCTAssert(sut.characters.count == 1)
        CharacterEntityAssert.assertCharacter(sut.characters[0], equals: expected.results[0])
        
        await sut.onRequestMoreCharacters()
        
        XCTAssertFalse(sut.isError)
        XCTAssertFalse(sut.characters.isEmpty)
        XCTAssert(sut.characters.count == 2)
        CharacterEntityAssert.assertCharacter(sut.characters[0], equals: expected.results[0])
        CharacterEntityAssert.assertCharacter(sut.characters[1], equals: expected.results[0])*/
    }
    
    func test_execute_onRequestMoreCharacters_whenNoMorePages() async {
        let expected = CharacterEntityFactory.makeListEntity()
        await useCase.setMockResponse(expected)
        
        /*XCTAssertFalse(sut.isError)
        XCTAssertTrue(sut.characters.isEmpty)
        
        await sut.onRefresh()
        
        XCTAssertFalse(sut.isError)
        XCTAssertFalse(sut.characters.isEmpty)
        XCTAssert(sut.characters.count == 1)
        CharacterEntityAssert.assertCharacter(sut.characters[0], equals: expected.results[0])
        
        await sut.onRequestMoreCharacters()
        
        XCTAssertFalse(sut.isError)
        XCTAssertFalse(sut.characters.isEmpty)
        XCTAssert(sut.characters.count == 1)
        CharacterEntityAssert.assertCharacter(sut.characters[0], equals: expected.results[0])*/
    }
    
    func test_execute_onRequestMoreCharacters_whenUseCaseFails() async {
        let expected = CharacterEntityFactory.makeListTwoPagesEntity()
        await useCase.setMockResponse(expected)
        
        /*XCTAssertFalse(sut.isError)
        XCTAssertTrue(sut.characters.isEmpty)
        
        await sut.onRefresh()
        
        XCTAssertFalse(sut.isError)
        XCTAssertFalse(sut.characters.isEmpty)
        XCTAssert(sut.characters.count == 1)
        CharacterEntityAssert.assertCharacter(sut.characters[0], equals: expected.results[0])
        
        await useCase.setMockError(UseCaseError.generic)
        await sut.onRequestMoreCharacters()
        
        XCTAssertTrue(sut.isError)
        XCTAssertFalse(sut.characters.isEmpty)
        XCTAssert(sut.characters.count == 1)
        CharacterEntityAssert.assertCharacter(sut.characters[0], equals: expected.results[0])*/
    }
}
