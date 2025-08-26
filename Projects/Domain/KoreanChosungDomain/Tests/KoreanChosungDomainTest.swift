import XCTest
@testable import KoreanChosungDomain

final class KoreanChosungDomainTests: XCTestCase {
    private var sut: KoreanChosungUsecaseImpl!
    
    override func setUpWithError() throws {
        sut = KoreanChosungUsecaseImpl()
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func test_given_초성_속담_when_usecase_then_정답() throws {
        // given
        let inputs = [
            "가는 말이 고와야 오는 말이 곱다",
            "고래 싸움에 새우 등 터진다",
            "소 잃고 외양간 고친다",
            "호랑이 굴에 가야 호랑이를 잡는다",
            "백지장도 맞들면 낫다",
            "우물 안 개구리",
            "원숭이도 나무에서 떨어진다",
            "까마귀 날자 배 떨어진다",
            "티끌 모아 태산",
            "식은 죽 먹기"
        ]
        
        let expected = [
            "ㄱㄴ ㅁㅇ ㄱㅇㅇ ㅇㄴ ㅁㅇ ㄱㄷ",
            "ㄱㄹ ㅆㅇㅇ ㅅㅇ ㄷ ㅌㅈㄷ",
            "ㅅ ㅇㄱ ㅇㅇㄱ ㄱㅊㄷ",
            "ㅎㄹㅇ ㄱㅇ ㄱㅇ ㅎㄹㅇㄹ ㅈㄴㄷ",
            "ㅂㅈㅈㄷ ㅁㄷㅁ ㄴㄷ",
            "ㅇㅁ ㅇ ㄱㄱㄹ",
            "ㅇㅅㅇㄷ ㄴㅁㅇㅅ ㄸㅇㅈㄷ",
            "ㄲㅁㄱ ㄴㅈ ㅂ ㄸㅇㅈㄷ",
            "ㅌㄲ ㅁㅇ ㅌㅅ",
            "ㅅㅇ ㅈ ㅁㄱ"
        ]
        
        // when
        let results = sut.getChosung(type: .chosung, inputs: inputs.map({ input in
            return .init(id: input, origin: input)
        }))
        
        print(results)
        
        // then
        for (index, result) in results.enumerated() {
            XCTAssertTrue(
                result.question == expected[index],
                "\(result.answer) 자음만 분리된 글자와 동일해야 한다."
            )
        }
    }
    
    func test_given_중성_속담_when_usecase_then_정답() throws {
        // given
        let inputs = [
            "가는 말이 고와야 오는 말이 곱다",
            "고래 싸움에 새우 등 터진다",
            "소 잃고 외양간 고친다",
            "호랑이 굴에 가야 호랑이를 잡는다",
            "백지장도 맞들면 낫다",
            "우물 안 개구리",
            "원숭이도 나무에서 떨어진다",
            "까마귀 날자 배 떨어진다",
            "티끌 모아 태산",
            "식은 죽 먹기"
        ]

        let expected = [
            "ㅏㅡ ㅏㅣ ㅗㅘㅑ ㅗㅡ ㅏㅣ ㅗㅏ",
            "ㅗㅐ ㅏㅜㅔ ㅐㅜ ㅡ ㅓㅣㅏ",
            "ㅗ ㅣㅗ ㅚㅑㅏ ㅗㅣㅏ",
            "ㅗㅏㅣ ㅜㅔ ㅏㅑ ㅗㅏㅣㅡ ㅏㅡㅏ",
            "ㅐㅣㅏㅗ ㅏㅡㅕ ㅏㅏ",
            "ㅜㅜ ㅏ ㅐㅜㅣ",
            "ㅝㅜㅣㅗ ㅏㅜㅔㅓ ㅓㅓㅣㅏ",
            "ㅏㅏㅟ ㅏㅏ ㅐ ㅓㅓㅣㅏ",
            "ㅣㅡ ㅗㅏ ㅐㅏ",
            "ㅣㅡ ㅜ ㅓㅣ"
        ]
        
        // when
        let results = sut.getChosung(type: .jungsung, inputs: inputs.map({ input in
            return .init(id: input, origin: input)
        }))
        
        print(results)
        
        // then
        for (index, result) in results.enumerated() {
            XCTAssertTrue(
                result.question == expected[index],
                "\(result.answer) 모음만 분리된 글자와 동일해야 한다."
            )
        }
    }
    
    func test_given_앞글자_다양하게_when_usecase_then_정답() throws {
        // given
        let inputs = [
            "까마귀 날자 배 떨어진다",
            "식은 죽 먹기",
            "고진감래",
            "호랑이 굴에 가야 호랑이를 잡는다",
            "백지장도 맞들면 낫다",
            "우물 안 개구리",
            "원숭이도 나무에서 떨어진다",
            "티끌 모아 태산",
            "가는 말이 고와야 오는 말이 곱다",
            "아메리카노"
        ]

        // 앞글자 기준 (makeHalfMaskedHint)
        let expected = [
            "까마귀 날자 O OOOO",
            "식은 죽 OO",
            "고진OO",
            "호랑이 굴에 가야 OOOO OOO",
            "백지장도 맞들면 OO",
            "우물 안 OOO",
            "원숭이도 나무에서 OOOO",
            "티끌 모아 OO",
            "가는 말이 고와야 OO OO OO",
            "아메리OO"
        ]
        
        // when
        let results = sut.getChosung(type: .frontHalf, inputs: inputs.map({ input in
            return .init(id: input, origin: input)
        }))
        
        print(results)
        
        // then
        for (index, result) in results.enumerated() {
            XCTAssertTrue(
                result.question == expected[index],
                "\(result.answer) 앞글자만 노출되어야 한다."
            )
        }
    }
    
    func test_given_뒷글자_다양하게_when_usecase_then_정답() throws {
        // given
        let inputs = [
            "까마귀 날자 배 떨어진다",
            "식은 죽 먹기",
            "고진감래",
            "호랑이 굴에 가야 호랑이를 잡는다",
            "백지장도 맞들면 낫다",
            "우물 안 개구리",
            "원숭이도 나무에서 떨어진다",
            "티끌 모아 태산",
            "가는 말이 고와야 오는 말이 곱다",
            "아메리카노"
        ]

        // 뒷글자 기준 (makeHalfMaskedHintFromEnd)
        let expected = [
            "OOO OO 배 떨어진다",
            "OO 죽 먹기",
            "OO감래",
            "OOO OO 가야 호랑이를 잡는다",
            "OOOO 맞들면 낫다",
            "OO 안 개구리",
            "OOOO 나무에서 떨어진다",
            "OO 모아 태산",
            "OO OO OOO 오는 말이 곱다",
            "OO리카노"
        ]
        
        // when
        let results = sut.getChosung(type: .backHalf, inputs: inputs.map({ input in
            return .init(id: input, origin: input)
        }))
        
        print(results)
        
        // then
        for (index, result) in results.enumerated() {
            XCTAssertTrue(
                result.question == expected[index],
                "\(result.answer) 뒷글자만 노출되어야 한다."
            )
        }
    }
}
