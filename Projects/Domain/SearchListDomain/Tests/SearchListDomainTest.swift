import XCTest

@testable import SearchListDomain
@testable import SearchListDomainTesting

final class SearchListDomainTests: XCTestCase {
    
    private var repository: MockSearchListRepository!
    private var sut: SearchListUseCaseImpl!
    
    override func setUpWithError() throws {
        self.repository = MockSearchListRepository()
        self.sut = SearchListUseCaseImpl(repository: self.repository)
    }

    override func tearDownWithError() throws {
        self.sut = nil
        self.repository = nil
    }
    
    func test_given_normal_when_execute_fetch_then_hasItems() async throws {
        // given
        let term: String = "검색어"
        
        // when
        let response = await self.sut.execute(SearchListInputImpl(
            query: term,
            isMore: false
        ))
        
        // then
        switch response {
        case .success:
            XCTAssertTrue(true)
            
        case .failure:
            XCTFail("정상적인 요청의 경우 error가 발생해선 안됩니다.")
        }
    }
    
    func test_given_normal_when_execute_more_then_hasItems() async throws {
        // given
        let term: String = "검색어"
        
        // when
        let response = await sut.execute(SearchListInputImpl(
            query: term,
            isMore: true
        ))
        
        // then
        switch response {
        case .success:
            XCTFail("fetch를 요청하지 않고, more부터 부를 경우 error가 발생합니다.")
            
        case .failure:
            XCTAssertTrue(
                true,
                "fetch를 요청하지 않고, more부터 부를 경우 error가 발생합니다."
            )
        }
    }
    
    func test_given_error_when_execute_fetch_then_error() async throws {
        // given
        let term: String = "검색어"
        let isError: Bool = true
        self.repository.setUp(isError: isError)
        
        // when
        let response = await sut.execute(SearchListInputImpl(
            query: term
        ))
        
        // then
        switch response {
        case .success:
            XCTFail("repository에서 Error가 발생한다면, usecase에서도 에러가 발생해야합니다.")
            
        case .failure:
            XCTAssertTrue(
                true,
                "repository에서 Error가 발생한다면, usecase에서도 에러가 발생해야합니다."
            )
        }
    }
    
    func test_given_items20_when_execute_fetch_then_items_20() async throws {
        // given
        let term: String = "검색어"
        let count: Int = 20
        
        self.repository.setUp(itemCount: count)
        
        // when
        let response = await sut.execute(SearchListInputImpl(
            query: term
        ))
        
        // then
        switch response {
        case .success(let success):
            XCTAssertTrue(
                success.items.count == count,
                "repository에서 발생한 값과 거의 같은 값을 얻습니다."
            )
            
        case .failure:
            XCTFail("repository에서 발생한 값과 거의 같은 값을 얻습니다.")
        }
    }
    
    func test_given_term_empty_when_execute_more_then_error() async throws {
        // given
        let term: String = ""
        self.repository.setUp(isError: false)
        
        // when
        let response = await self.sut.execute(SearchListInputImpl(
            query: term,
            isMore: false
        ))
        
        // then
        switch response {
        case .success(let success):
            XCTAssertTrue(
                success.items.count == 0,
                "검색어가 없다면 빈 배열이 돌아옵니다."
            )
            
        case .failure:
            XCTFail("검색어가 없다면 빈 배열이 돌아옵니다.")
        }
    }
    
    func test_given_term_email_when_execute_more_then_error() async throws {
        // given
        let term: String = "test@test.com"
        self.repository.setUp(isError: false)
        
        // when
        let response = await self.sut.execute(SearchListInputImpl(
            query: term,
            isMore: false
        ))
        
        // then
        switch response {
        case .success(let success):
            XCTAssertTrue(
                success.items.count == 0,
                "검색어가 이름 형식이 아니라면 빈 배열이 돌아옵니다."
            )
            
        case .failure:
            XCTFail("검색어가 이름 형식이 아니라면 빈 배열이 돌아옵니다.")
        }
    }
}
