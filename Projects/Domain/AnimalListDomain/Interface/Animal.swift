import Foundation
import GameEntityDomainInterface

public protocol Animal: Identifiable, GameEntity {
    var category: any CategoryEntity { get }
    var itemCategory2: (any CategoryEntity)? { get }
    func imageNameStyle(_ style: AnimalImageStyle) -> String?
}
