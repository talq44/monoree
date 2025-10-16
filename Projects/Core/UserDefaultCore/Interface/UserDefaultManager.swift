import Foundation

public protocol UserDefaultTargetType {
    associatedtype Value: Codable
    var key: String { get }
    var suiteName: String? { get }
    var defaultValue: Value? { get }
}

public extension UserDefaultTargetType {
    var suiteName: String? { nil }
    var defaultValue: Value? { nil }
}

public struct UserDefaultKey<Value: Codable>: UserDefaultTargetType {
    public let key: String
    public let suiteName: String?
    public let defaultValue: Value?

    public init(
        _ key: String,
        suiteName: String? = nil,
        defaultValue: Value? = nil
    ) {
        self.key = key
        self.suiteName = suiteName
        self.defaultValue = defaultValue
    }
}

public protocol UserDefaultManageable {
    func value<T: UserDefaultTargetType>(for target: T) -> T.Value?
    func set<T: UserDefaultTargetType>(_ value: T.Value?, for target: T)
    func remove<T: UserDefaultTargetType>(_ target: T)
    func contains<T: UserDefaultTargetType>(_ target: T) -> Bool
}
