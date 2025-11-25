import Foundation
import AnimalListDomainInterface
import GameEntityDomainInterface

final class CategoryListUseCaseImpl: CategoryListUseCase {
    func fetch() async -> [any GameEntityDomainInterface.CategoryEntity] {
        return []
    }
}
