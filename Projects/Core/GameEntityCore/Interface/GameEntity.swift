import Foundation

public protocol GameEntity {
    var id: String { get }
    var names: [NameEntity] { get }
    var category: CategoryEntity { get }
    var itemCategory2: CategoryEntity? { get }
    var imageName: String? { get }
}
