import Foundation

public enum ThumbnailType: String, CaseIterable, Identifiable {
    public var id: String { String(describing: self) }
    
    case square_Large
    case circle_Large
    case square_Medium
    case circle_Medium
    case square_Small
    case circle_Small
    
    var size: CGFloat {
        switch self {
        case .square_Large, .circle_Large:
            return 120
        case .square_Medium, .circle_Medium:
            return 80
        case .square_Small, .circle_Small:
            return 48
        }
    }
    
    var isCircle: Bool {
        switch self {
        case .circle_Large, .circle_Medium, .circle_Small:
            return true
        default:
            return false
        }
    }
}
