import Foundation
import AnimalListDomainInterface
import GameEntityDomainInterface

struct AnimalDTO: Decodable {
    let id: String
    let names: [NameDTO]
    let categoryID: String
    let itemCategory2ID: String?
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

