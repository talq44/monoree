import Foundation
import GamePlayFeatureInterface
import RemoteConfigCoreInterface

enum GameConfigTestType {
    case normal(perAd: Int)
    case error
}

final class GameConfigManagerMock: GameConfigManager {
    private var testType: GameConfigTestType = .normal(perAd: 0)
    
    func setup(_ type: GameConfigTestType) {
        self.testType = type
    }
    
    func fetchGame() throws -> any RemoteConfigCoreInterface.GameConfigDTO {
        switch testType {
        case .normal(let perAd):
            return GameConfigDTOMock(gamePlaysPerAd: perAd)
        case .error:
            throw RemoteConfigError.unknown
        }
    }
}

struct GameConfigDTOMock: RemoteConfigCoreInterface.GameConfigDTO {
    let gamePlaysPerAd: Int
}
