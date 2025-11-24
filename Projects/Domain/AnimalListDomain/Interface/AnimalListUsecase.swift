import Foundation

public protocol AnimalListUsecase {
    func fetch() async -> [Animal]
}
