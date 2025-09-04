import Foundation
import UserGameSettingDomainInterface
import RemoteConfigCoreInterface

final class GameConfigManagerMock: GameConfigManager {
    func fetchGame() throws -> any RemoteConfigCoreInterface.GameConfigDTO {
        return GameConfigDTOStub(
            gamePlaysPerAd: 5,
            questionCount: 10,
            timePerQuestion: 10,
            teamCount: 10
        )
    }
}

struct GameConfigDTOStub: GameConfigDTO {
    var gamePlaysPerAd: Int
    var questionCount: Int
    var timePerQuestion: Int
    var teamCount: Int
}
