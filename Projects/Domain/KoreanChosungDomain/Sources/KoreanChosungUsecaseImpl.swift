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
        }
    }
    
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
