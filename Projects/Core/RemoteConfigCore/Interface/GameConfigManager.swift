import Foundation

public protocol GameConfigManager {
    func fetchGame() throws -> GameConfigDTO
}
