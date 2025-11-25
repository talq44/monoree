import Foundation
import AnimalListDomainInterface
import GameEntityDomainInterface

final class AnimalCategoryListUseCaseImpl: AnimalCategoryListUseCase {
    func fetch() async -> [any CategoryEntity] {
        guard let url = Bundle.module.url(
            forResource: "categories",
            withExtension: "json"
        ) else {
            print("Failed to find categories.json in bundle")
            return []
        }
        
        do {
            let data = try Data(contentsOf: url)
            let categoryDTOs = try JSONDecoder().decode([CategoryDTO].self, from: data)
            
            return categoryDTOs
        } catch {
            print("Error decoding categories: \(error)")
            return []
        }
    }
}
