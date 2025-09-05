import Foundation

public enum GameDetailActionType {
    case categoryPlus
    case categoryMinus
    case category1(id: String)
    case category2(id: String)
    case question(count: Int)
    case secondPerQuestion(second: Int)
    case tema(count: Int)
    case hint(Bool)
    case custom(id: String, type: String)
}
