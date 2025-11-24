import Foundation
import AnimalListDomainInterface
import GameEntityDomainInterface

struct AnimalDTO: Decodable {
    let id: String
    let names: [NameDTO]
    let category: CategoryDTO
    let itemCategory2: CategoryDTO?
}

// MARK: - DTOs
struct NameDTO: Decodable, NameEntity {
    let languageCode: String
    let name: String
}

struct CategoryDTO: Decodable, CategoryEntity {
    var id: String
    var name: String
    var names: [NameEntity]

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case names
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.names = try container.decode([NameDTO].self, forKey: .names)
    }
}

