import Foundation

enum NormalIntTestType {
    case normal(Int)
    case error
    
    var value: Int? {
        switch self {
        case .normal(let value):
            return value
        case .error:
            return nil
        }
    }
}
