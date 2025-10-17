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
        let expected = makeCharacterEntity()
        await repository.setMockResponse(expected)
        
        let result = await sut.execute(data: "0")
        
        switch result {
        case .success(let character):
            assertCharacter(character, equals: expected)
        case .failure(let error):
            XCTFail("Expected success but got failure: \(error)")
        }
    }
    
    func test_execute_returnsError_whenRepositoryFails() async {
        await repository.setMockError(RepositoryError.notFound)
        
        let result = await sut.execute(data: "0")
        
        switch result {
        case .success(let character):
            XCTFail("Expected failure but got success: \(character)")
        case .failure(let error):
            XCTAssertEqual(error, .generic)
        }
    }
    
    // MARK: - Helpers
    
    private func makeCharacterEntity() -> CharacterEntity {
        CharacterEntity(
            id: 0,
            name: "Name",
            status: "Status",
            species: "Species",
            type: "Type",
            gender: "Gender",
            origin: "OriginName",
            location: "LocationName",
            image: "Image"
        )
    }
    
    private func assertCharacter(_ character: CharacterEntity, equals expected: CharacterEntity, file: StaticString = #filePath, line: UInt = #line) {
        XCTAssertEqual(character.id, expected.id, file: file, line: line)
        XCTAssertEqual(character.name, expected.name, file: file, line: line)
        XCTAssertEqual(character.status, expected.status, file: file, line: line)
        XCTAssertEqual(character.species, expected.species, file: file, line: line)
        XCTAssertEqual(character.type, expected.type, file: file, line: line)
        XCTAssertEqual(character.gender, expected.gender, file: file, line: line)
        XCTAssertEqual(character.origin, expected.origin, file: file, line: line)
        XCTAssertEqual(character.location, expected.location, file: file, line: line)
        XCTAssertEqual(character.image, expected.image, file: file, line: line)
    }
}
