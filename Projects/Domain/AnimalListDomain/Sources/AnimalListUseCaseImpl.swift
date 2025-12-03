import Foundation
import AnimalListDomainInterface
import GameEntityDomainInterface

// MARK: - UseCase Implementation
final public class AnimalListUseCaseImpl: AnimalListUseCase {
    public init() { }
    
    public func fetch() async -> [any GameEntityDomainInterface.GameEntity] {
        guard let animalListURL = Bundle.module.url(
            forResource: "animal_list",
            withExtension: "json"
        ) else {
            print("Failed to find animal_list.json in bundle")
            return []
        }

        do {
            let animalData = try Data(contentsOf: animalListURL)
            let animalDTOs = try JSONDecoder().decode([AnimalDTO].self, from: animalData)
            
            return animalDTOs
        } catch {
            print("Error decoding animal list: \(error)")
            return []
        }
    }
}
