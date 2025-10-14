import Foundation
import RemoteConfigCoreInterface

extension RemoteConfigManagerImpl: HomeConfigManager {
    func fetch(
        _ type: RemoteConfigCoreInterface.HomeConfigType
    ) throws -> RemoteConfigCoreInterface.HomeDTO {
        return try fetchRemoteConfig(
            HomeDTO.self,
            stringKey: type.rawValue
        )
    }
}
