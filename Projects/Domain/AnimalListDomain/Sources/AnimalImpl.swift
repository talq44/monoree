import Foundation
import GameEntityDomainInterface
import AnimalListDomainInterface

struct AnimalImpl: Animal {
    let id: String
    let names: [any NameEntity]
    let category: any CategoryEntity
    let itemCategory2: (any CategoryEntity)?
    
    var categoryID: String {
        category.id
    }
    
    var itemCategory2ID: String? {
        itemCategory2?.id
    }
    
    func imageName(_ type: String) -> String? {
        return type + "_" + id + ".webp"
    }
    
    func imageNameStyle(_ style: AnimalListDomainInterface.AnimalImageStyle) -> String? {
        return style.rawValue + "_" + id + ".webp"
    }
}
