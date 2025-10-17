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
    
    func test_execute_returnsCharacter_whenNetworkServiceSucceeds() async {
        let expected = CharacterResponseFactory.makeCharacterResponse()
        await service.setMockGetResponse(expected)
        
        do {
            let result = try await sut.getCharacter(characterId: "0")
            CharacterResponseAssert.assertCharacter(result, equals: expected.toDomain())
        } catch {
            XCTFail("Expected success but got error: \(error)")
        }
    }
    
    func test_execute_returnsError_whenNetworkServiceFails() async {
        await service.setMockError(NetworkError.invalidURL)
        
        do {
            let result = try await sut.getCharacter(characterId: "0")
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
