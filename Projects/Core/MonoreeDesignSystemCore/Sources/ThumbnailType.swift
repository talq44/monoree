import Foundation

public enum ThumbnailType: String, CaseIterable, Identifiable {
    public var id: String { String(describing: self) }
    
    case squareLarge
    case circleLarge
    case squareMedium
    case circleMedium
    case squareSmall
    case circleSmall
    
    var size: CGFloat {
        switch self {
        case .squareLarge, .circleLarge:
            return 120
        case .squareMedium, .circleMedium:
            return 80
        case .squareSmall, .circleSmall:
            return 48
        }
    }
    
    var isCircle: Bool {
        switch self {
        case .circleLarge, .circleMedium, .circleSmall:
            return true
        default:
            return false
        }
    }
    
    var cornerRadius: CGFloat {
        return isCircle ? size / 2 : 16
    }
}
