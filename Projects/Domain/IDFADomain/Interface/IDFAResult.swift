import Foundation

public enum IDFAResult: Equatable {
    case new(id: String)
    case before(id: String)
    case notAllowed
}
