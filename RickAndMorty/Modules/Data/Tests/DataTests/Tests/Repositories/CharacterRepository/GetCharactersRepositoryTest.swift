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

final class GetCharactersRepositoryTest: XCTestCase {
    
    private var service: NetworkServiceMock!
    private var sut: CharacterRepositoryImpl!
    
    override func setUp() {
        super.setUp()
        
        let mock = NetworkServiceMock()
        service = mock
        
        Container.shared.manager.push()
        Container.shared.networkService.register { mock }
        
        sut = CharacterRepositoryImpl()
    }
    
    override func tearDown() {
        sut = nil
        service = nil
        
        Container.shared.manager.pop()
        super.tearDown()
    }
    
    func test_execute_returnsCharacters_whenNetworkServiceSucceeds() async {
        let expected = CharacterResponseFactory.makeListResponse()
        await service.setMockGetResponse(expected)
        
        do {
            let result = try await sut.getCharacters(page: 1, search: "")
            CharacterResponseAssert.assertCharacterList(result, equals: expected.toDomain())
        } catch {
            XCTFail("Expected success but got error: \(error)")
        }
    }
    
    func test_execute_returnsError_whenNetworkServiceFails() async {
        await service.setMockError(NetworkError.invalidURL)
        
        do {
            let result = try await sut.getCharacters(page: 1, search: "")
            XCTFail("Expected failure but got success: \(result)")
        } catch {
            switch error {
            case .generic:
                break
            default:
                XCTFail("Expected failure with generic error")
            }
        }
    }
}
