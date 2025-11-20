//
//  CharacterListViewModelTest.swift
//  Presentation
//
//  Created by Pedro Juan Baeza Gómez on 17/10/25.
//

import XCTest
import Factory
import Combine
import Domain
@testable import Presentation

@MainActor
final class CharacterListViewModelTest: XCTestCase {
    
    private var useCase: GetCharactersUseCaseMock!
    private var sut: CharacterListViewModel!
    
    override func setUp() async throws {
        try await super.setUp()
        
        let mock = GetCharactersUseCaseMock()
        useCase = mock
        
        Container.shared.manager.push()
        Container.shared.getCharactersUseCase.register { mock }
        
        sut = CharacterListViewModel(router: nil)
    }
    
    override func tearDown() async throws {
        sut = nil
        useCase = nil
        
        Container.shared.manager.pop()
        try await super.tearDown()
    }
    
    func test_onRefresh_waitsForModuleUpdate() async {
        let expected = CharacterEntityFactory.makeListEntity()
        let testExpectation = testExpectationCellsNotEmptyModule()
        await useCase.setMockResponse(expected)
        
        XCTAssertNotNil(sut.module as? any ListRepresentable)
        let before = sut.module as! any ListRepresentable
        XCTAssertTrue(before.listDataSource.cells.isEmpty)
        
        before.onRefresh()
        await fulfillment(of: [testExpectation], timeout: 1)
        
        XCTAssertNotNil(sut.module as? any ListRepresentable)
        let after = sut.module as! any ListRepresentable
        XCTAssertFalse(after.listDataSource.cells.isEmpty)
        
        let count = after.listDataSource.cells.count { $0 is any CharacterListCellModule }
        XCTAssertEqual(count, expected.results.count)
    }
    
    
    func test_execute_onRefresh_whenUseCaseFails() async {
        let testExpectation = testExpectationErrorModule()
        await useCase.setMockError(UseCaseError.generic)
        
        XCTAssertNotNil(sut.module as? any ListRepresentable)
        let before = sut.module as! any ListRepresentable
        XCTAssertTrue(before.listDataSource.cells.isEmpty)
        
        before.onRefresh()
        await fulfillment(of: [testExpectation], timeout: 1)
        
        XCTAssertNotNil(sut.module as? any ErrorRepresentable)
    }
}

private extension CharacterListViewModelTest {
    
    func testExpectationCellsNotEmptyModule() -> XCTestExpectation {
        waitUntil(description: "testExpectationCellsNotEmptyModule") {
            if let list = self.sut.module as? any ListRepresentable {
                return !list.listDataSource.cells.isEmpty
            }
            return false
        }
    }

    
    func testExpectationErrorModule() -> XCTestExpectation {
        waitUntil(description: "testExpectationErrorModule") {
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
