import Foundation

public protocol GameConfigManager {
    func fetchGameConfig() throws -> GameConfigDTO
}
