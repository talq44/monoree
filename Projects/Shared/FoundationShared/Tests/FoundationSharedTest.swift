import XCTest

import FoundationShared
final class FoundationSharedTests: XCTestCase {
    
    override func setUpWithError() throws {}

    override func tearDownWithError() throws {}

    func test_given_기억할게_when_초성_then_ㄱ_한글자음() {
        // given
        let input = "기억할게"
        // when
        let result = input.chosung()
        // then
        XCTAssertEqual(result, "ㄱ")
    }
    
    func test_given_developer_when_초성_then_d_영어() {
        // given
        let input = "developer"
        // when
        let result = input.chosung()
        // then
        XCTAssertEqual(result, "d")
    }
    
    func test_given_Apple_when_초성_then_A_대소문자() {
        // given
        let input = "Apple"
        // when
        let result = input.chosung()
        // then
        XCTAssertEqual(result, "A")
    }
    
    func test_given_Apple_when_초성_isLower_true_then_a_소문자로_변경() {
        // given
        let input = "Apple"
        // when
        let result = input.chosung(isLower: true)
        // then
        XCTAssertEqual(result, "a")
    }
    
    func test_given_211224_when_초성_then_2_숫자() {
        // given
        let input = "211224"
        // when
        let result = input.chosung()
        // then
        XCTAssertEqual(result, "2")
    }
}
