import Foundation
import GameEntityDomainInterface
import AnimalListDomainInterface

struct AnimalImpl: Animal {
    let id: String
    let names: [any GameEntityDomainInterface.NameEntity]
    let category: any GameEntityDomainInterface.CategoryEntity
    let itemCategory2: (any GameEntityDomainInterface.CategoryEntity)?
    
    func imageName(_ type: String) -> String? {
        return type + "_" + id + ".webp"
    }
    
    func imageNameStyle(_ style: AnimalListDomainInterface.AnimalImageStyle) -> String? {
        return style.rawValue + "_" + id + ".webp"
    }
}
