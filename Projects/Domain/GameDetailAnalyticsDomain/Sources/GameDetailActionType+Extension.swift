import Foundation
import FoundationShared
import GameDetailAnalyticsDomainInterface

extension GameDetailActionType {
    var content_id: String {
        switch self {
        case .categoryPlus: return "plus"
        case .categoryMinus: return "minus"
        case .category1(let id): return id
        case .category2(let id): return id
        case .question(let count): return count.toString
        case .secondPerQuestion(let second): return second.toString
        case .team(let count): return count.toString
        case .hint(let bool): return bool.toString
        case .custom(let id, _): return id
        }
    }
    
    var content_type: String {
        switch self {
        case .categoryPlus: return "category"
        case .categoryMinus: return "category"
        case .category1: return "item_category1"
        case .category2: return "item_category2"
        case .question: return toName
        case .secondPerQuestion: return "second_per_question"
        case .team: return toName
        case .hint: return toName
        case .custom(_, let type): return type
        }
    }
    
    private var toName: String {
        return String(describing: self)
            .components(separatedBy: "(")
            .first ?? ""
    }
}
