import Foundation
import GameEntityDomainInterface
import AnimalListDomainInterface

struct AnimalImpl: Animal {
    let id: String
    let names: [any NameEntity]
    let categoryID: String
    let itemCategory2ID: String?
    
    func imageName(_ type: String) -> String? {
        return type + "_" + id + ".webp"
    }
    
    func imageNameStyle(_ style: AnimalListDomainInterface.AnimalImageStyle) -> String? {
        return style.rawValue + "_" + id + ".webp"
    }
}
