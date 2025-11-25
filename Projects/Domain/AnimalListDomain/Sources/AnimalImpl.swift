import Foundation
import GameEntityDomainInterface
import AnimalListDomainInterface

struct AnimalImpl: Animal {
    let id: String
    let names: [any NameEntity]
    let category: any CategoryEntity
    let itemCategory2: (any CategoryEntity)?
    
    func imageNameStyle(_ style: AnimalListDomainInterface.AnimalImageStyle) -> String? {
        return style.rawValue + "_" + id + ".webp"
    }
}
