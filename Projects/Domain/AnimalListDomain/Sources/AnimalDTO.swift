import Foundation
import AnimalListDomainInterface
import GameEntityDomainInterface

struct AnimalDTO: Decodable, GameEntity, Localizable {
    let id: String
    let names: [any NameEntity]
    let categoryID: String
    let itemCategory2ID: String?
    
    enum CodingKeys: String, CodingKey {
        case id, names, categoryID, itemCategory2ID
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.names = try container.decode([NameDTO].self, forKey: .names)
        self.categoryID = try container.decode(String.self, forKey: .categoryID)
        self.itemCategory2ID = try container.decodeIfPresent(String.self, forKey: .itemCategory2ID)
    }
    
    func imageName(_ type: String) -> String? {
        return type + "_" + id + ".webp"
    }
}

// MARK: - DTOs
struct NameDTO: Decodable, NameEntity {
    let languageCode: String
    let name: String
}

struct CategoryDTO: Decodable, CategoryEntity {
    var id: String
    var name: String
    var names: [any NameEntity]
    var parentId: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case names
        case parentId
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.names = try container.decode([NameDTO].self, forKey: .names)
        self.parentId = try container.decodeIfPresent(String.self, forKey: .parentId)
    }
}

