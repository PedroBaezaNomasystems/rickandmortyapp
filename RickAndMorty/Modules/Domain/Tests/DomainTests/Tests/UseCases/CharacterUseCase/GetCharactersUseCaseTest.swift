//
//  GetCharactersUseCaseTest.swift
//  Domain
//
//  Created by Pedro Juan Baeza Gómez on 16/10/25.
//

import XCTest
import Factory
@testable import Domain

final class GetCharactersUseCaseTests: XCTestCase {
    
    private var repository: CharacterRepositoryMock!
    private var sut: GetCharactersUseCaseImpl!
    
    override func setUp() {
        super.setUp()
        
        let mock = CharacterRepositoryMock()
        repository = mock
        
        Container.shared.manager.push()
        Container.shared.characterRepository.register { mock }
        
        sut = GetCharactersUseCaseImpl()
    }
    
    override func tearDown() {
        sut = nil
        repository = nil
        
        Container.shared.manager.pop()
        super.tearDown()
    }
    
    func test_execute_returnsCharacters_whenRepositorySucceeds() async {
        let expected = CharacterEntityFactory.makeListEntity()
        await repository.setMockResponse(expected)
        
        let result = await sut.execute(data: "")
        
        switch result {
        case .success(let response):
            CharacterEntityAssert.assertCharacterList(response, equals: expected)
        case .failure(let error):
            XCTFail("Expected success but got failure: \(error)")
        }
    }
    
    func test_execute_returnsError_whenRepositoryFails() async {
        await repository.setMockError(.notFound)
        
        let result = await sut.execute(data: "")
        
        switch result {
        case .success(let response):
            XCTFail("Expected failure but got success: \(response)")
        case .failure(let error):
            XCTAssertEqual(error, .generic)
        }
    }
}
