import Foundation

public protocol GameListUseCase {
    func fetch() async -> [any GameEntity]
}
