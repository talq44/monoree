import Foundation
import RemoteConfigCoreInterface

extension RemoteConfigManagerImpl: GameConfigManager {
    func fetchGame() throws -> any RemoteConfigCoreInterface.GameConfigDTO {
        return try fetchRemoteConfig(
            GameConfigDTOImpl.self,
            key: .game
        )
    }
}
