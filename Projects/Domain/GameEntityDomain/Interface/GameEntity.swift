import Foundation

public protocol GameEntity: Localizable {
    var id: String { get }
    var categoryID: String { get }
    var itemCategory2ID: String? { get }
    
    func imageName(_ type: String) -> String?
}
