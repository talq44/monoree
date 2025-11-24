import Foundation
import AnimalListDomainInterface

final class AnimalListUseCaseImpl: AnimalListUsecase {
    func fetch() async -> [any AnimalListDomainInterface.Animal] {
        return []
    }
}
