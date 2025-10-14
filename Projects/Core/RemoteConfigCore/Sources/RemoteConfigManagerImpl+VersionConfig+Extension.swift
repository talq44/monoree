import Foundation
import RemoteConfigCoreInterface

extension RemoteConfigManagerImpl: VersionConfigManager {
    func version() throws -> any VersionDTO {
        return try fetchRemoteConfig(
            VersionDTOImpl.self,
            key: .version
        )
    }
    
    func fetchVersion() async throws -> any RemoteConfigCoreInterface.VersionDTO {
        try await fetchAndActivate()
        
        return try fetchRemoteConfig(
            VersionDTOImpl.self,
            key: .version
        )
    }
}
