import Foundation
import GameEntityDomainInterface

public protocol Animal: GameEntity, Identifiable {
    func imageNameStyle(_ style: AnimalImageStyle) -> String?
}
