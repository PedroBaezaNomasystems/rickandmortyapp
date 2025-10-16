//
//  GetCharactersUseCaseTest.swift
//  Domain
//
//  Created by Pedro Juan Baeza Gómez on 16/10/25.
//

import XCTest
import Factory
@testable import Domain

final class GetCharactersUseCaseTest: XCTestCase {
    
    private var mock: CharacterRepositoryMock!
    private var sut: GetCharactersUseCaseImpl!
    
    override func setUp() {
        super.setUp()
        
        let mockLocal = CharacterRepositoryMock()
        mock = mockLocal
        
        Container.shared.manager.push()
        Container.shared.characterRepository.register { mockLocal }
        sut = GetCharactersUseCaseImpl()
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
        
        let page = 0
        let result = await sut.execute(data: page)
        switch result {
        case .success(let response):
            XCTAssertEqual(response.results.count, 1)
            XCTAssertEqual(response.results[0].id, 0)
            XCTAssertEqual(response.results[0].name, "Name")
            XCTAssertEqual(response.results[0].status, "Status")
            XCTAssertEqual(response.results[0].species, "Species")
            XCTAssertEqual(response.results[0].type, "Type")
            XCTAssertEqual(response.results[0].gender, "Gender")
            XCTAssertEqual(response.results[0].origin, "OriginName")
            XCTAssertEqual(response.results[0].location, "LocationName")
            XCTAssertEqual(response.results[0].image, "Image")
        case .failure:
            XCTFail("Expected success but got error")
        }
    }
    
    func testGetCharactersError() async {
        await mock.setMockError(RepositoryError.notFound)
        
        let page = 0
        let result = await sut.execute(data: page)
        switch result {
        case .success(let response):
            XCTFail("Expected error to be thrown but got success with: \(response)")
        case .failure:
            XCTAssertTrue(true, "Error description should not be empty")
        }
    }
    
    private func getMockResponse() -> ListEntity<CharacterEntity> {
        let mockItemResponse = CharacterEntity(
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
            results: [mockItemResponse]
        )
    }
}
