import Foundation
import AnimalListDomainInterface
import GameEntityDomainInterface

// MARK: - UseCase Implementation
final class AnimalListUseCaseImpl: AnimalListUsecase {
    func fetch() async -> [Animal] {
        guard let url = Bundle.module.url(
            forResource: "animal_list",
            withExtension: "json"
        ) else {
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
