import XCTest
import Factory
import Domain
@testable import Data

final class GetCharactersRepositoryTest: XCTestCase {
    
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
            let result = try await sut.getCharacters(page: 1)
            XCTAssertEqual(result.count, 1)
            XCTAssertEqual(result.results[0].name, "Name")
            XCTAssertEqual(result.results[0].status, "Status")
            XCTAssertEqual(result.results[0].species, "Species")
            XCTAssertEqual(result.results[0].type, "Type")
            XCTAssertEqual(result.results[0].gender, "Gender")
            XCTAssertEqual(result.results[0].origin, "OriginName")
            XCTAssertEqual(result.results[0].location, "LocationName")
            XCTAssertEqual(result.results[0].image, "Image")
        } catch {
            XCTFail("Expected success but got error: \(error)")
        }
    }
    
    func testGetCharactersError() async {
        await mock.setMockError(NetworkError.invalidURL)
        
        do {
            let result = try await sut.getCharacters(page: 1)
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
    
    private func getMockResponse() -> ListResponse<CharacterResponse> {
        let mockInfoResponse = ListInfoResponse(
            count: 1,
            pages: 1,
            next: "Next",
            previous: "Previous"
        )
        
        let mockItemResponse = CharacterResponse(
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
        
        return ListResponse<CharacterResponse>(
            info: mockInfoResponse,
            results: [mockItemResponse]
        )
    }
}
