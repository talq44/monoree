import Foundation
import RemoteConfigCoreInterface

extension RemoteConfigManagerImpl: HomeConfigManager {
    func home(
        _ type: RemoteConfigCoreInterface.HomeConfigType
    ) throws -> RemoteConfigCoreInterface.HomeDTO {
        return try fetchRemoteConfig(
            HomeDTO.self,
            stringKey: type.rawValue
        )
    }
    
    func fetchHome(
        _ type: RemoteConfigCoreInterface.HomeConfigType
    ) async throws -> RemoteConfigCoreInterface.HomeDTO {
        try await fetchAndActivate()
        
        return try home(type)
    }
}
