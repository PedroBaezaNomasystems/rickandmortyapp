//
//  GetCharacterRepositoryTest.swift
//  Data
//
//  Created by Pedro Juan Baeza Gómez on 16/10/25.
//

import XCTest
import Factory
import Domain
@testable import Data

final class GetCharacterRepositoryTest: XCTestCase {
    
    private var mock: NetworkServiceMock!
    private var sut: CharacterRepositoryImpl!
    
    override func setUp() {
        super.setUp()
        
        let mockLocal = NetworkServiceMock()
        mock = mockLocal
        
        Container.shared.manager.push()
        Container.shared.networkService.register { mockLocal }
        sut = CharacterRepositoryImpl()
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
        
        do {
            let result = try await sut.getCharacter(characterId: "0")
            XCTAssertEqual(result.id, 0)
            XCTAssertEqual(result.name, "Name")
            XCTAssertEqual(result.status, "Status")
            XCTAssertEqual(result.species, "Species")
            XCTAssertEqual(result.type, "Type")
            XCTAssertEqual(result.gender, "Gender")
            XCTAssertEqual(result.origin, "OriginName")
            XCTAssertEqual(result.location, "LocationName")
            XCTAssertEqual(result.image, "Image")
        } catch {
            XCTFail("Expected success but got error: \(error)")
        }
    }
    
    func testGetCharactersError() async {
        await mock.setMockError(NetworkError.invalidURL)
        
        do {
            let result = try await sut.getCharacter(characterId: "0")
            XCTFail("Expected error to be thrown but got success with: \(result)")
        } catch {
            switch error {
            case .generic(let description):
                XCTAssertTrue(!description.isEmpty, "Error description should not be empty")
            default:
                XCTFail("Expected RepositoryError.generic but got \(type(of: error)): \(error)")
            }
        }
    }
    
    private func getMockResponse() -> CharacterResponse {
        return CharacterResponse(
            id: 0,
            name: "Name",
            status: "Status",
            species: "Species",
            type: "Type",
            gender: "Gender",
            origin: CharacterOriginResponse(name: "OriginName", url: "OriginUrl"),
            location: CharacterLocationResponse(name: "LocationName", url: "LocationUrl"),
            image: "Image"
        )
    }
}
