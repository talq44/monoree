import Foundation

public protocol HomeConfigManager {
    func fetch(_ type: HomeConfigType) throws -> HomeDTO
}
