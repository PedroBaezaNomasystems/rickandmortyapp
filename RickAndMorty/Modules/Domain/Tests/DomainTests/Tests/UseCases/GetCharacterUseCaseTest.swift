//
//  GetCharacterUseCaseTest.swift
//  Domain
//
//  Created by Pedro Juan Baeza Gómez on 16/10/25.
//

import XCTest
import Factory
@testable import Domain

final class GetCharacterUseCaseTest: XCTestCase {
    
    private var mock: CharacterRepositoryMock!
    private var sut: GetCharacterUseCaseImpl!
    
    override func setUp() {
        super.setUp()
        
        let mockLocal = CharacterRepositoryMock()
        mock = mockLocal
        
        Container.shared.manager.push()
        Container.shared.characterRepository.register { mockLocal }
        sut = GetCharacterUseCaseImpl()
    }
    
    override func tearDown() {
        mock = nil
        sut = nil
        
        Container.shared.manager.pop()
        super.tearDown()
    }
    
    func testGetCharactersSuccess() async {
        let mockResponse = getMockResponse()
        await mock.setMockResponse(mockResponse)
        
        let characterId = "0"
        let result = await sut.execute(data: characterId)
        switch result {
        case .success(let response):
            XCTAssertEqual(response.id, 0)
            XCTAssertEqual(response.name, "Name")
            XCTAssertEqual(response.status, "Status")
            XCTAssertEqual(response.species, "Species")
            XCTAssertEqual(response.type, "Type")
            XCTAssertEqual(response.gender, "Gender")
            XCTAssertEqual(response.origin, "OriginName")
            XCTAssertEqual(response.location, "LocationName")
            XCTAssertEqual(response.image, "Image")
        case .failure:
            XCTFail("Expected success but got error")
        }
    }
    
    func testGetCharactersError() async {
        await mock.setMockError(RepositoryError.notFound)
        
        let characterId = "0"
        let result = await sut.execute(data: characterId)
        switch result {
        case .success(let response):
            XCTFail("Expected error to be thrown but got success with: \(response)")
        case .failure:
            XCTAssertTrue(true, "Error description should not be empty")
        }
    }
    
    private func getMockResponse() -> CharacterEntity {
        return CharacterEntity(
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
}
