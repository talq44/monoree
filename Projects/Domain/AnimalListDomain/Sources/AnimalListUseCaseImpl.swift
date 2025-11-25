import Foundation
import AnimalListDomainInterface
import GameEntityDomainInterface

// MARK: - UseCase Implementation
final class AnimalListUseCaseImpl: AnimalListUseCase {
    func fetch() async -> [any GameEntityDomainInterface.GameEntity] {
        // 1. Load categories.json
        guard let categoryURL = Bundle.module.url(forResource: "categories", withExtension: "json") else {
            print("Failed to find categories.json in bundle")
            return []
        }

        let categories: [CategoryDTO]
        do {
            let categoryData = try Data(contentsOf: categoryURL)
            categories = try JSONDecoder().decode([CategoryDTO].self, from: categoryData)
        } catch {
            print("Error decoding categories: \(error)")
            return []
        }

        // 2. Create a category lookup dictionary
        let categoryDict = Dictionary(uniqueKeysWithValues: categories.map { ($0.id, $0 as CategoryEntity) })

        // 3. Load animal_list.json
        guard let animalListURL = Bundle.module.url(forResource: "animal_list", withExtension: "json") else {
            print("Failed to find animal_list.json in bundle")
            return []
        }

        do {
            let animalData = try Data(contentsOf: animalListURL)
            let animalDTOs = try JSONDecoder().decode([AnimalDTO].self, from: animalData)
            
            // 4. Compose Animal objects
            let animals: [any Animal] = animalDTOs.compactMap { dto in
                guard let category = categoryDict[dto.categoryID] else {
                    print("Warning: Category not found for ID \(dto.categoryID)")
                    return nil
                }
                
                let itemCategory2 = dto.itemCategory2ID.flatMap { categoryDict[$0] }
                
                return AnimalImpl(
                    id: dto.id,
                    names: dto.names,
                    category: category,
                    itemCategory2: itemCategory2
                )
            }
            return animals
        } catch {
            print("Error decoding animal list: \(error)")
            return []
        }
    }
}
