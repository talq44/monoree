import Foundation

enum GameTyp {
    case image
    case text
    case autoScroll
    
    var isShowSpeakButton: Bool {
        switch self {
        case .image:
            return false
        case .text:
            return true
        case .autoScroll:
            return true
        }
    }
}
