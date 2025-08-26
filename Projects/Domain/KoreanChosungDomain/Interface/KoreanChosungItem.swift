import Foundation

public protocol KoreanChosungItem {
    var id: String { get }
    var origin: String { get }
    var answer: String { get }
    var question: String { get }
}
