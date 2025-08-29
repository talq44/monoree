import Foundation
import GamePlayFeatureInterface
import RemoteConfigCoreInterface

final class GameConfigManagerMock: GameConfigManager {
    private var perAd: Int = 0
    
    func setup(perAd: Int) {
        self.perAd = perAd
    }
    
    func fetchGame() throws -> any RemoteConfigCoreInterface.GameConfigDTO {
        return GameConfigDTOMock(gamePlaysPerAd: perAd)
    }
}

struct GameConfigDTOMock: RemoteConfigCoreInterface.GameConfigDTO {
    let gamePlaysPerAd: Int
}
