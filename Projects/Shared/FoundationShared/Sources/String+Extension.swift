//
//  String+Extension.swift
//  FoundationShared
//
//  Created by 박창규 on 12/4/24.
//

import Foundation

public extension String {
    /// 한글 및 알파벳의 초성을 가지고 옵니다.
    /// - parameters:
    ///     - isLower: true - 소문자만 사용, false : 소문자/대문자 혼용
    func chosung(isLower: Bool = false) -> String {
        let text = isLower ? self.lowercased() : self
        let baseUnicode: UInt32 = 0xAC00
        let choSeongOffsets = [
            "ㄱ", "ㄲ", "ㄴ", "ㄷ", "ㄸ", "ㄹ", "ㅁ", "ㅂ", "ㅃ", "ㅅ", "ㅆ",
            "ㅇ", "ㅈ", "ㅉ", "ㅊ", "ㅋ", "ㅌ", "ㅍ", "ㅎ"
        ]
        
        var result = ""
        
        for character in text {
            let unicodeValue = character.unicodeScalars.first?.value ?? 0
            
            if (0xAC00...0xD7A3).contains(unicodeValue) {
                // 한글 초성 추출
                let choSeongIndex = Int((unicodeValue - baseUnicode) / 28 / 21)
                result.append(choSeongOffsets[choSeongIndex])
            } else if character.isLetter || character.isNumber {
                // 알파벳 또는 숫자의 첫 글자 그대로 사용
                result.append(character)
            }
            break
        }
        
        return result
    }
}
