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
        let expected = makeListEntity()
        await repository.setMockResponse(expected)
        
        let result = await sut.execute(data: 0)
        
        switch result {
        case .success(let response):
            assertCharacterList(response, equals: expected)
        case .failure(let error):
            XCTFail("Expected success but got failure: \(error)")
        }
    }
    
    func test_execute_returnsError_whenRepositoryFails() async {
        await repository.setMockError(.notFound)
        
        let result = await sut.execute(data: 0)
        
        switch result {
        case .success(let response):
            XCTFail("Expected failure but got success: \(response)")
        case .failure(let error):
            XCTAssertEqual(error, .generic)
        }
    }
    
    // MARK: - Helpers
    
    private func makeListEntity() -> ListEntity<CharacterEntity> {
        let character = CharacterEntity(
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
        
        return ListEntity(
            count: 1,
            pages: 1,
            next: nil,
            previous: nil,
            results: [character]
        )
    }
    
    private func assertCharacterList(
        _ actual: ListEntity<CharacterEntity>,
        equals expected: ListEntity<CharacterEntity>,
        file: StaticString = #filePath,
        line: UInt = #line
    ) {
        XCTAssertEqual(actual.count, expected.count, file: file, line: line)
        XCTAssertEqual(actual.pages, expected.pages, file: file, line: line)
        XCTAssertEqual(actual.results.count, expected.results.count, file: file, line: line)
        
        if let actualCharacter = actual.results.first,
           let expectedCharacter = expected.results.first {
            assertCharacter(actualCharacter, equals: expectedCharacter, file: file, line: line)
        }
    }
    
    private func assertCharacter(
        _ actual: CharacterEntity,
        equals expected: CharacterEntity,
        file: StaticString = #filePath,
        line: UInt = #line
    ) {
        XCTAssertEqual(actual.id, expected.id, file: file, line: line)
        XCTAssertEqual(actual.name, expected.name, file: file, line: line)
        XCTAssertEqual(actual.status, expected.status, file: file, line: line)
        XCTAssertEqual(actual.species, expected.species, file: file, line: line)
        XCTAssertEqual(actual.type, expected.type, file: file, line: line)
        XCTAssertEqual(actual.gender, expected.gender, file: file, line: line)
        XCTAssertEqual(actual.origin, expected.origin, file: file, line: line)
        XCTAssertEqual(actual.location, expected.location, file: file, line: line)
        XCTAssertEqual(actual.image, expected.image, file: file, line: line)
    }
}
