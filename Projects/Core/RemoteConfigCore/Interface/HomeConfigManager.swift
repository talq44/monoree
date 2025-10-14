import Foundation

public protocol HomeConfigManager {
    func home(_ type: HomeConfigType) throws -> HomeDTO
    func fetchHome(_ type: HomeConfigType) async throws -> HomeDTO
}
