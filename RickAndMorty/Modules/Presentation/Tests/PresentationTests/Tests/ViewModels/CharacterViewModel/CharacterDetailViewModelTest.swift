//
//  CharacterDetailViewModelTest.swift
//  Presentation
//
//  Created by Pedro Juan Baeza Gómez on 17/10/25.
//

import XCTest
import Factory
import Domain
@testable import Presentation

@MainActor
final class CharacterDetailViewModelTest: XCTestCase {
    
    private var useCase: GetCharacterUseCaseMock!
    private var sut: CharacterDetailViewModel!
    
    override func setUp() async throws {
        try await super.setUp()
        
        let mock = GetCharacterUseCaseMock()
        useCase = mock
        
        Container.shared.manager.push()
        Container.shared.getCharacterUseCase.register { mock }
        
        sut = CharacterDetailViewModel(characterId: 1, router: nil)
    }
    
    override func tearDown() async throws {
        sut = nil
        useCase = nil
        
        Container.shared.manager.pop()
        try await super.tearDown()
    }
    
    func test_execute_onAppear_whenUseCaseSucceeds() async {
        let expected = CharacterEntityFactory.makeCharacterEntity()
        let testExpectation = testExpectationScrollRepresentable()
        await useCase.setMockResponse(expected)
        
        XCTAssertNotNil(sut.module as? any LoadingRepresentable)
        let loading = sut.module as! any LoadingRepresentable
        
        loading.onAppear()
        await fulfillment(of: [testExpectation], timeout: 1)
        
        XCTAssertNotNil(sut.module as? any ScrollRepresentable)
        let scroll = sut.module as! any ScrollRepresentable
        XCTAssertFalse(scroll.scrollDataSource.modules.isEmpty)
    }
    
    func test_execute_onAppear_whenUseCaseFails() async {
        let testExpectation = testExpectationErrorRepresentable()
        await useCase.setMockError(UseCaseError.generic)
        
        XCTAssertNotNil(sut.module as? any LoadingRepresentable)
        let loading = sut.module as! any LoadingRepresentable
        
        loading.onAppear()
        await fulfillment(of: [testExpectation], timeout: 1)
        
        XCTAssertNotNil(sut.module as? any ErrorRepresentable)
    }
}

private extension CharacterDetailViewModelTest {
    
    func testExpectationScrollRepresentable() -> XCTestExpectation {
        waitUntil(description: "testExpectationScrollRepresentable") {
            self.sut.module is any ScrollRepresentable
        }
    }
    
    func testExpectationErrorRepresentable() -> XCTestExpectation {
        waitUntil(description: "testExpectationErrorRepresentable") {
            self.sut.module is any ErrorRepresentable
        }
    }
    
    private func waitUntil(description: String, check condition: @escaping () -> Bool) -> XCTestExpectation {
        let expectation = expectation(description: description)

        Task {
            while true {
                if condition() { break }
                try? await Task.sleep(nanoseconds: 5_000_000)
            }
            
            expectation.fulfill()
        }

        return expectation
    }
}
