import Foundation
import RemoteConfigCoreInterface

extension RemoteConfigManagerImpl: GameConfigManager {
    func fetchGame() throws -> any RemoteConfigCoreInterface.GameConfigDTO {
        do {
            let response = try fetchRemoteConfig(
                GameConfigDTOImpl.self,
                key: .game
            )
            
            return response
        } catch {
            throw error
        }
    }
}
