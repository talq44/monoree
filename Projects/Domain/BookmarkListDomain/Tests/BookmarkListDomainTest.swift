import XCTest

@testable import BookmarkListDomain
@testable import BookmarkListDomainTesting

final class BookmarkListDomainTests: XCTestCase {
    
    private var repository: StubBookMarkListRepository!
    private var sut: BookmarkListUseCaseImpl!
    
    override func setUpWithError() throws {
        self.repository = StubBookMarkListRepository()
        self.sut = BookmarkListUseCaseImpl(
            repository: self.repository
        )
    }

    override func tearDownWithError() throws {
        self.sut = nil
        self.repository = nil
    }

    func test_given_성공적인케이스_when_execute_then_목록을_돌려주는가() async throws {
        // given
        let query: String = "검색어"
        self.repository.setUp(
            searchWord: query,
            searchWordContains: true
        )
        
        // when
        let response = self.sut.execute(
            BookmarkListInputImpl(query: query)
        )
        
        // then
        switch response {
        case .success(let success):
            XCTAssertTrue(
                success.items.count > 0,
                "성공적인 케이스의 경우 정상적인 값을 돌려줘야 합니다."
            )
                          
        case .failure:
            XCTFail("성공적인 케이스의 경우 정상적인 값을 돌려줘야 합니다.")
        }
    }
    
    func test_given_빈검색어_when_execute_then_목록을_돌려주는가() async throws {
        // given
        let query: String = ""
        self.repository.setUp(
            searchWord: query,
            searchWordContains: true
        )
        
        // when
        let response = self.sut.execute(
            BookmarkListInputImpl(query: query)
        )
        
        // then
        switch response {
        case .success(let success):
            XCTAssertTrue(
                success.items.count > 0,
                "빈값 케이스의 경우 정상적인 값을 돌려줘야 합니다."
            )
                          
        case .failure:
            XCTFail("빈값 케이스의 경우 정상적인 값을 돌려줘야 합니다.")
        }
    }
    
    func test_given_검색어가_없는케이스_when_execute_then_목록이_없는가() async throws {
        // given
        let query: String = "굉장히특별한이름아주아주특별한"
        self.repository.setUp(
            searchWord: query,
            searchWordContains: false
        )
        
        // when
        let response = self.sut.execute(
            BookmarkListInputImpl(query: query)
        )
        
        // then
        switch response {
        case .success(let success):
            XCTAssertTrue(
                success.items.count == 0,
                "이름에 해당하는 목록이 없다면 []를 돌려주야합니다."
            )
                          
        case .failure:
            XCTFail("이름에 해당하는 목록이 없다면 []를 돌려주야합니다.")
        }
    }
    
    func test_given_에러발생케이스_when_execute_then_에러가발생하는가() async throws {
        // given
        let query: String = "검색어"
        self.repository.setUp(
            searchWord: query,
            searchWordContains: true,
            isError: true
        )
        
        // when
        let response = self.sut.execute(
            BookmarkListInputImpl(query: query)
        )
        
        // then
        switch response {
        case .success:
            XCTFail("repository에서 에러가 발생한다면 에러를 돌려주야합니다.")
                          
        case .failure:
            XCTAssertTrue(true)
        }
    }
}
