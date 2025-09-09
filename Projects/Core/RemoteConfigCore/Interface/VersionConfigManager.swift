import Foundation

public protocol VersionConfigManager {
    func version() throws -> any VersionDTO
    func fetchVersion() async throws -> any VersionDTO
}
