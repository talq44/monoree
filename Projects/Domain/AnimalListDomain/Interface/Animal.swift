import Foundation
import GameEntityDomainInterface

public protocol Animal: Identifiable, GameEntity {
    func imageNameStyle(_ style: AnimalImageStyle) -> String?
}
