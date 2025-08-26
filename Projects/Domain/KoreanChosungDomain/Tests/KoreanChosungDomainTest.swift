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

extension KoreanChosungDomainTests {

    // MARK: - Generated edge and invariant tests (XCTest Extension)
    // Test library/framework used: XCTest (Apple standard for Swift)

    // Invariant helpers:
    // - For .chosung output, it must NOT contain Hangul vowel jamo (ㅏ-ㅣ, U+314F...U+3163)
    // - For .jungsung output, it must NOT contain Hangul consonant jamo (ㄱ-ㅎ, U+3131...U+314E)
    // Non-Hangul (ASCII, digits, punctuation, emoji, etc.) are allowed to pass through.
    private func doesNotContainJungseongJamo(_ s: String) -> Bool {
        for v in s.unicodeScalars.map(\.value) {
            if v >= 0x314F && v <= 0x3163 { return false }
        }
        return true
    }

    private func doesNotContainChoseongJamo(_ s: String) -> Bool {
        for v in s.unicodeScalars.map(\.value) {
            if v >= 0x3131 && v <= 0x314E { return false }
        }
        return true
    }

    func test_emptyInputs_allTypes_returnsEmpty() throws {
        let empty: [KoreanChosungInput] = []
        let r1 = sut.getChosung(type: .chosung,  inputs: empty)
        let r2 = sut.getChosung(type: .jungsung, inputs: empty)
        let r3 = sut.getChosung(type: .frontHalf, inputs: empty)
        let r4 = sut.getChosung(type: .backHalf,  inputs: empty)

        XCTAssertEqual(r1.count, 0)
        XCTAssertEqual(r2.count, 0)
        XCTAssertEqual(r3.count, 0)
        XCTAssertEqual(r4.count, 0)
    }

    func test_emptyStringItem_preserved_across_all_types() throws {
        let inputs = [KoreanChosungInput(id: "", origin: "")]
        let r1 = sut.getChosung(type: .chosung,  inputs: inputs).first!
        let r2 = sut.getChosung(type: .jungsung, inputs: inputs).first!
        let r3 = sut.getChosung(type: .frontHalf, inputs: inputs).first!
        let r4 = sut.getChosung(type: .backHalf,  inputs: inputs).first!

        XCTAssertEqual(r1.id, "")
        XCTAssertEqual(r1.answer, "")
        XCTAssertEqual(r1.question, "")

        XCTAssertEqual(r2.id, "")
        XCTAssertEqual(r2.answer, "")
        XCTAssertEqual(r2.question, "")

        XCTAssertEqual(r3.id, "")
        XCTAssertEqual(r3.answer, "")
        XCTAssertEqual(r3.question, "")

        XCTAssertEqual(r4.id, "")
        XCTAssertEqual(r4.answer, "")
        XCTAssertEqual(r4.question, "")
    }

    func test_mixedAndNonKorean_inputs_invariantsHold() throws {
        // Includes ASCII, digits, punctuation, emoji, mixed Hangul/ASCII
        let original = [
            "ABC 123 !!!",
            "🙂 emoji test",
            "서울 Seoul 123",
            "가A나1다!"
        ]
        let inputs = original.map { KoreanChosungInput(id: $0, origin: $0) }

        let rc = sut.getChosung(type: .chosung, inputs: inputs)
        let rj = sut.getChosung(type: .jungsung, inputs: inputs)
        let rf = sut.getChosung(type: .frontHalf, inputs: inputs)
        let rb = sut.getChosung(type: .backHalf, inputs: inputs)

        XCTAssertEqual(rc.count, original.count)
        XCTAssertEqual(rj.count, original.count)
        XCTAssertEqual(rf.count, original.count)
        XCTAssertEqual(rb.count, original.count)

        for i in 0..<original.count {
            // Stability: ids and answers should echo the inputs
            XCTAssertEqual(rc[i].id, original[i])
            XCTAssertEqual(rj[i].id, original[i])
            XCTAssertEqual(rc[i].answer, original[i])
            XCTAssertEqual(rj[i].answer, original[i])
            XCTAssertEqual(rf[i].answer, original[i])
            XCTAssertEqual(rb[i].answer, original[i])

            // Invariants: no disallowed jamo in each variant
            XCTAssertTrue(doesNotContainJungseongJamo(rc[i].question), "chosung output should not contain vowel jamo: \(rc[i].question)")
            XCTAssertTrue(doesNotContainChoseongJamo(rj[i].question), "jungsung output should not contain consonant jamo: \(rj[i].question)")

            // Half masking should introduce 'O' for multi-syllable Korean segments
            if original[i].contains("서울") || original[i].contains("가A나1다!") {
                XCTAssertTrue(rf[i].question.contains("O") || rb[i].question.contains("O"),
                              "Half-mask should introduce 'O' for multi-syllable Korean segments.")
            }
        }
    }

    func test_singleSyllables_decomposition_chosung_and_jungsung() throws {
        // Simple deterministic samples
        let originals = ["가", "나", "다", " ", "가 나"]
        let inputs = originals.map { KoreanChosungInput(id: $0, origin: $0) }

        let rC = sut.getChosung(type: .chosung, inputs: inputs)
        let rJ = sut.getChosung(type: .jungsung, inputs: inputs)

        XCTAssertEqual(rC.count, inputs.count)
        XCTAssertEqual(rJ.count, inputs.count)

        // Known splits: 가(ㄱ+ㅏ), 나(ㄴ+ㅏ), 다(ㄷ+ㅏ)
        let expectedChosung = ["ㄱ", "ㄴ", "ㄷ", " ", "ㄱ ㄴ"]
        let expectedJungsung = ["ㅏ", "ㅏ", "ㅏ", " ", "ㅏ ㅏ"]

        for i in 0..<originals.count {
            XCTAssertEqual(rC[i].question, expectedChosung[i], "chosung mismatch for '\(originals[i])'")
            XCTAssertEqual(rJ[i].question, expectedJungsung[i], "jungsung mismatch for '\(originals[i])'")
            XCTAssertEqual(rC[i].answer, originals[i])
            XCTAssertEqual(rJ[i].answer, originals[i])
        }
    }

    func test_bulkInputs_resultCount_and_nonEmpty_questions() throws {
        let base = "호랑이 굴에 가야 호랑이를 잡는다"
        let inputs: [KoreanChosungInput] = (0..<200).map { idx in
            let s = idx % 2 == 0 ? base : "가는 말이 고와야 오는 말이 곱다"
            return KoreanChosungInput(id: "\(idx)", origin: s)
        }

        let results = sut.getChosung(type: .chosung, inputs: inputs)
        XCTAssertEqual(results.count, inputs.count)

        for (i, res) in results.enumerated() {
            XCTAssertFalse(res.answer.isEmpty, "Answer must not be empty at index \(i).")
            XCTAssertFalse(res.question.isEmpty, "Question must not be empty at index \(i).")
        }
    }

    func test_frontHalf_backHalf_masksComplementary() throws {
        let phrase = "까마귀 날자 배 떨어진다"
        let input = [KoreanChosungInput(id: "id-1", origin: phrase)]

        let front = sut.getChosung(type: .frontHalf, inputs: input).first!
        let back  = sut.getChosung(type: .backHalf,  inputs: input).first!

        XCTAssertTrue(front.question.contains("O"), "frontHalf should mask trailing parts with 'O'.")
        XCTAssertTrue(back.question.contains("O"), "backHalf should mask leading parts with 'O'.")
        XCTAssertNotEqual(front.question, back.question, "frontHalf and backHalf masks should differ.")
        XCTAssertNotEqual(front.question, phrase, "frontHalf question should not equal full phrase.")
        XCTAssertNotEqual(back.question, phrase, "backHalf question should not equal full phrase.")
    }
}
