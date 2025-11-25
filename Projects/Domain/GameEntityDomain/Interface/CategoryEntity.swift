import Foundation

public protocol CategoryEntity: Localizable {
    var id: String { get }
    var name: String { get }
    var parentId: String? { get }
}
