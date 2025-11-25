import Foundation
import AnimalListDomainInterface
import GameEntityDomainInterface

final class CategoryListUseCaseImpl: AnimalCategoryListUseCase {
    func fetch() async -> [any GameEntityDomainInterface.CategoryEntity] {
        return []
    }
}
