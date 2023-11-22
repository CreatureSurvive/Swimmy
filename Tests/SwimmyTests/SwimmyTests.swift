import XCTest
import Combine
@testable import Swimmy

final class SwimmyTests: XCTestCase {
    
    let endpoint = URL(string: "https://lemmy.world/api/v3")!
    let requests: [any APIRequest] = [
        GetSiteRequest(),
        GetPersonDetailsRequest(username: "CreatureSurvive"),
        GetPostsRequest(),
        GetCommentsRequest()
    ]
    
    func testAPI() async throws {
        let api = try LemmyAPI(baseUrl: endpoint)
        
        for request in requests {
            do {
                _ = try await api.request(request)
            } catch {
                XCTFail(
                    """
                    Expected result \(String(describing: requests.self)) Response,
                    Error: \(error)
                    Description: \(error.localizedDescription)
                    """,
                    file: #file,
                    line: #line
                )
            }
        }
    }
    
    func testCombineAPI() async throws {
        let api = try LemmyAPI(baseUrl: endpoint)
        var cancellables = Set<AnyCancellable>()
        
        for request in requests {
            do {
                let (response, error) = await api.request(request, store: &cancellables)
                if let error = error {
                    throw error
                }
                XCTAssert(response != nil, "Found nil for response: \(String(describing: requests.self))")
            } catch {
                XCTFail(
                    """
                    Expected result \(String(describing: requests.self)) Response,
                    Error: \(error)
                    Description: \(error.localizedDescription)
                    """,
                    file: #file,
                    line: #line
                )
            }
        }
    }
}
