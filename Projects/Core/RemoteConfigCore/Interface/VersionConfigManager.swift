import Foundation

public protocol VersionConfigManager {
    func fetchVersion() throws -> any VersionDTO
}
