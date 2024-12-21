import XCTest

import UserAPICoreInterface
@testable import UserAPICore

final class UserAPIProtocolTests: XCTestCase {
    
    private var dataSource: UserAPIProtocol!
    override func setUpWithError() throws {
        self.dataSource = UserAPICoreImpl(
            baseURL: Constants.baseURL
        )
    }

    override func tearDownWithError() throws {
        self.dataSource = nil
    }

    func test_given_검색어입력_when_request_then_결과돌려줌() async throws {
        // given
        let header = SearchHeaderDTO(
            token: Constants.githubToken
        )
        let request = SearchRequestDTO(
            q: "dev",
            per_page: nil,
            page: nil
        )
        do {
            // when
            let response = try await dataSource.get_search_users(
                header: header,
                request: request
            )
            
            // then
            XCTAssertTrue(
                response.items.count > 0,
                "정상적인 통신을 하면, 결과가 반환되어야 합니다."
            )
        } catch {
            throw error
        }
    }
}
