import Foundation
import KoreanChosungDomainInterface

struct KoreanChosungItemImpl: KoreanChosungItem, Equatable {
    let id: String
    let origin: String
    let answer: String
    let question: String
}
