import Foundation

public protocol KoreanChosungItem: Equatable, Identifiable {
    var id: String { get }
    var origin: String { get }
    var answer: String { get }
    var question: String { get }
}
