//
//  GetCharacterUseCaseTest.swift
//  Domain
//
//  Created by Pedro Juan Baeza Gómez on 16/10/25.
//

import XCTest
import Factory
@testable import Domain

final class GetCharacterUseCaseTests: XCTestCase {
    
    private var repository: CharacterRepositoryMock!
    private var sut: GetCharacterUseCaseImpl!
    
    override func setUp() {
        super.setUp()
        
        let mock = CharacterRepositoryMock()
        repository = mock
        
        Container.shared.manager.push()
        Container.shared.characterRepository.register { mock }
        
        sut = GetCharacterUseCaseImpl()
    }
    
    override func tearDown() {
        sut = nil
        repository = nil
        
        Container.shared.manager.pop()
        super.tearDown()
    }
    
    func test_execute_returnsCharacter_whenRepositorySucceeds() async {
        let expected = CharacterEntityFactory.makeCharacterEntity()
        await repository.setMockResponse(expected)
        
        let result = await sut.execute(data: 0)
        
        switch result {
        case .success(let character):
            CharacterEntityAssert.assertCharacter(character, equals: expected)
        case .failure(let error):
            XCTFail("Expected success but got failure: \(error)")
        }
    }
    
    func test_execute_returnsError_whenRepositoryFails() async {
        await repository.setMockError(RepositoryError.notFound)
        
        let result = await sut.execute(data: 0)
        
        switch result {
        case .success(let character):
            XCTFail("Expected failure but got success: \(character)")
        case .failure(let error):
            XCTAssertEqual(error, .generic)
        }
    }
}
