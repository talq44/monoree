import Foundation
import RemoteConfigCoreInterface

extension RemoteConfigManagerImpl: VersionConfigManager {
    func fetchVersion() throws -> any RemoteConfigCoreInterface.VersionDTO {
        return try fetchRemoteConfig(
            VersionDTOImpl.self,
            key: .version
        )
    }
}
