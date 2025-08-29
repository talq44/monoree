import Foundation
import RemoteConfigCoreInterface

public protocol GameLimitCheckUsecase {
    init(remoteConfig: GameConfigManager)
    
    func checkGamePlay() async -> GameNextActionType
}
