import Foundation

public protocol RemoteConfigFetchManager {
    func fetchAndActivate() async throws -> Void
}
