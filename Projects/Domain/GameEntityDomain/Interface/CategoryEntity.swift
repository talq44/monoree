import Foundation

public protocol CategoryEntity {
    var id: String { get }
    var name: String { get }
    var names: [NameEntity] { get }
}
