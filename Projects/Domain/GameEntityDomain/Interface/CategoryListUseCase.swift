import Foundation

public protocol CategoryListUseCase {
    func fetch() async -> [any CategoryEntity]
}
