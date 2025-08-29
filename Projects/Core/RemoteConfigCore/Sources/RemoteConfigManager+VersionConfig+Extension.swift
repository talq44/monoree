import Foundation
import RemoteConfigCoreInterface

extension RemoteConfigManagerImpl: VersionConfigManager {
    func fetchVersion() throws -> any RemoteConfigCoreInterface.VersionDTO {
        do {
            let response = try fetchRemoteConfig(
                VersionDTOImpl.self,
                key: .version
            )
            
            return response
        } catch {
            throw error
        }
    }
}
