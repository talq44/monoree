import Foundation
import KoreanChosungDomainInterface

final class KoreanChosungUsecaseImpl: KoreanChosungUsecase {
    func getChosung(
        type: KoreanChosungType,
        inputs: [KoreanChosungInput]
    ) -> [any KoreanChosungItem] {
        switch type {
        case .chosung:
            return chosungDivider(inputs: inputs)
        case .jungsung:
            return jungsungDivider(inputs: inputs)
        case .frontHalf:
            return frontDivider(inputs: inputs)
        case .backHalf:
            return backDivider(inputs: inputs)
        }
    }
}

// MARK: - Chosung
extension KoreanChosungUsecaseImpl {
    private func chosungDivider(
        inputs: [KoreanChosungInput]
    ) -> [KoreanChosungItemImpl] {
        let convertItems: [KoreanChosungItemImpl] = inputs.map { input in
            return KoreanChosungItemImpl(
                id: input.id,
                origin: input.origin,
                answer: input.origin,
                question: extractChoseong(from: input.origin)
            )
        }
        
        return convertItems
    }
    
    private func extractChoseong(from text: String) -> String {
        let choseongTable: [Character] = [
            "ㄱ","ㄲ","ㄴ","ㄷ","ㄸ","ㄹ","ㅁ","ㅂ","ㅃ","ㅅ","ㅆ","ㅇ","ㅈ","ㅉ","ㅊ","ㅋ","ㅌ","ㅍ","ㅎ"
        ]
        
        var result = String.UnicodeScalarView()
        result.reserveCapacity(text.unicodeScalars.count)
        
        for scalar in text.unicodeScalars {
            let value = scalar.value
            if 0xAC00...0xD7A3 ~= value {
                let sIndex = Int(value - 0xAC00)
                let choseongIndex = sIndex / 588
                let c = choseongTable[choseongIndex]
                for u in String(c).unicodeScalars {
                    result.append(u)
                }
            } else {
                result.append(scalar)
            }
        }
        return String(result)
    }
}

// MARK: - Jungsung
extension KoreanChosungUsecaseImpl {
    private func jungsungDivider(
        inputs: [KoreanChosungInput]
    ) -> [KoreanChosungItemImpl] {
        let convertItems: [KoreanChosungItemImpl] = inputs.map { input in
            KoreanChosungItemImpl(
                id: input.id,
                origin: input.origin,
                answer: input.origin,
                question: extractJungseong(from: input.origin)
            )
        }
        return convertItems
    }
    
    private func extractJungseong(from text: String) -> String {
        let jungseongTable: [Character] = [
            "ㅏ","ㅐ","ㅑ","ㅒ","ㅓ","ㅔ","ㅕ","ㅖ","ㅗ","ㅘ","ㅙ","ㅚ","ㅛ","ㅜ","ㅝ","ㅞ","ㅟ","ㅠ","ㅡ","ㅢ","ㅣ"
        ]
        
        var result = String.UnicodeScalarView()
        result.reserveCapacity(text.unicodeScalars.count)
        
        for scalar in text.unicodeScalars {
            let value = scalar.value
            if 0xAC00...0xD7A3 ~= value {
                let sIndex = Int(value - 0xAC00)
                let jungIndex = (sIndex % 588) / 28
                let v = jungseongTable[jungIndex]
                for u in String(v).unicodeScalars {
                    result.append(u)
                }
            } else {
                result.append(scalar)
            }
        }
        return String(result)
    }
}

// MARK: - Hint Masking (Whitespace or Continuous)
extension KoreanChosungUsecaseImpl {
    private func frontDivider(
        inputs: [KoreanChosungInput]
    ) -> [KoreanChosungItemImpl] {
        let convertItems: [KoreanChosungItemImpl] = inputs.map { input in
            KoreanChosungItemImpl(
                id: input.id,
                origin: input.origin,
                answer: input.origin,
                question: makeHalfMaskedHint(from: input.origin)
            )
        }
        return convertItems
    }
    
    /// Returns a hint string where only the first half is revealed and the rest is masked with "O".
    /// - Rules:
    ///   - If the text contains spaces: split by single spaces, show the first half (ceil), mask the remaining tokens with "O" repeated by each token's character count, then join using a single space.
    ///   - If the text has no spaces (e.g., 사자성어): reveal first half (ceil) characters, mask the rest with "O".
    ///   - Examples:
    ///     - "까마귀 날자 배 떨어진다" -> "까마귀 날자 O OOOO"
    ///     - "식은 죽 먹기"           -> "식은 죽 OO"
    ///     - "고진감래"               -> "고진OO"
    private func makeHalfMaskedHint(from text: String) -> String {
        // Fast-path: empty
        guard !text.isEmpty else { return text }
        
        // Determine if we treat as spaced phrase or continuous word
        if text.contains(" ") {
            // Split by a single space; join with a single space to keep consistency with examples
            let parts = text.split(separator: " ", omittingEmptySubsequences: true).map(String.init)
            guard !parts.isEmpty else { return text }
            
            let keepCount = (parts.count + 1) / 2 // ceil
            let masked = parts.enumerated().map { idx, token -> String in
                if idx < keepCount { return token }
                // Mask token length with "O"
                return String(repeating: "O", count: token.count)
            }
            return masked.joined(separator: " ")
        } else {
            // Continuous string (e.g., 사자성어)
            let count = text.count
            let keepCount = (count + 1) / 2 // ceil
            let prefixStr = String(text.prefix(keepCount))
            let maskedTail = String(repeating: "O", count: max(0, count - keepCount))
            return prefixStr + maskedTail
        }
    }
    
    private func backDivider(
        inputs: [KoreanChosungInput]
    ) -> [KoreanChosungItemImpl] {
        let convertItems: [KoreanChosungItemImpl] = inputs.map { input in
            KoreanChosungItemImpl(
                id: input.id,
                origin: input.origin,
                answer: input.origin,
                question: makeHalfMaskedHintFromEnd(from: input.origin)
            )
        }
        return convertItems
    }

    /// Returns a hint string where only the **last** half is revealed and the **front** is masked with "O".
    /// - Rules:
    ///   - If the text contains spaces: split by single spaces, show the last half (ceil), mask the preceding tokens with "O" repeated by each token's character count, then join using a single space.
    ///   - If the text has no spaces (e.g., 사자성어): reveal last half (ceil) characters, mask the front with "O".
    ///   - Examples:
    ///     - "까마귀 날자 배 떨어진다" -> "OOO OO 배 떨어진다"
    ///     - "식은 죽 먹기"           -> "OO 죽 먹기"
    ///     - "고진감래"               -> "OO감래"
    private func makeHalfMaskedHintFromEnd(from text: String) -> String {
        guard !text.isEmpty else { return text }
        
        if text.contains(" ") {
            let parts = text.split(separator: " ", omittingEmptySubsequences: true).map(String.init)
            guard !parts.isEmpty else { return text }
            
            let keepCount = (parts.count + 1) / 2 // ceil
            let threshold = parts.count - keepCount
            
            let masked = parts.enumerated().map { idx, token -> String in
                if idx < threshold {
                    return String(repeating: "O", count: token.count)
                } else {
                    return token
                }
            }
            return masked.joined(separator: " ")
        } else {
            let count = text.count
            let keepCount = (count + 1) / 2 // ceil
            let suffixStr = String(text.suffix(keepCount))
            let maskedHead = String(repeating: "O", count: max(0, count - keepCount))
            return maskedHead + suffixStr
        }
    }
}
