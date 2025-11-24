import Foundation
import GameEntityDomainInterface

public protocol Animal: GameEntity {
    func imageNameStyle(_ style: AnimalImageStyle) -> String?
}
