import Foundation
import AnimalListDomainInterface
import GameEntityDomainInterface

// MARK: - DTOs
private struct NameDTO: Decodable, NameEntity {
    let languageCode: String
    let name: String
}

private struct CategoryDTO: Decodable, CategoryEntity {
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

private struct AnimalDTO: Decodable {
    let id: String
    let names: [NameDTO]
    let category: CategoryDTO
    let itemCategory2: CategoryDTO?
}

// MARK: - UseCase Implementation
final class AnimalListUseCaseImpl: AnimalListUsecase {
    func fetch() async -> [Animal] {
        guard let url = Bundle.module.url(forResource: "animal_list", withExtension: "json") else {
            print("Failed to find animal_list.json in bundle")
            return []
        }

        do {
            let data = try Data(contentsOf: url)
            let animalDTOs = try JSONDecoder().decode([AnimalDTO].self, from: data)
            
            let animals: [Animal] = animalDTOs.map { dto in
                return AnimalImpl(
                    id: dto.id,
                    names: dto.names,
                    category: dto.category,
                    itemCategory2: dto.itemCategory2
                )
            }
            return animals
        } catch {
            print("Error decoding animal list: \(error)")
            return []
        }
    }
}
