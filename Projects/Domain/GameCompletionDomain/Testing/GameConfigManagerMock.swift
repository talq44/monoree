import Foundation
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
            return GameConfigDTOMock(
                questionCount: 0,
                timePerQuestion: 0,
                teamCount: 0,
                gamePlaysPerAd: perAd
            )
        case .error:
            throw RemoteConfigError.unknown
        }
    }
}

struct GameConfigDTOMock: RemoteConfigCoreInterface.GameConfigDTO {
    var questionCount: Int
    
    var timePerQuestion: Int
    
    var teamCount: Int
    
    let gamePlaysPerAd: Int
}
