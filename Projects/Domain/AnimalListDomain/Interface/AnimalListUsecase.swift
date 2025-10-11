import Foundation

public protocol AnimalListUsecase {
    func fetch(_ category: AnimalCategory) async -> [Animal]
}
