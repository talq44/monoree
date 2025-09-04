import Foundation
import UserGameSettingDomainInterface
import RemoteConfigCoreInterface

final class GameConfigManagerMock: GameConfigManager {
    private var testType: NormalIntTestType = .normal(3)
    
    func setup(testType: NormalIntTestType) {
        self.testType = testType
    }
    
    func fetchGame() throws -> any RemoteConfigCoreInterface.GameConfigDTO {
        guard let value = testType.value else {
            throw RemoteConfigError.unknown
        }
        
        return GameConfigDTOStub(
            gamePlaysPerAd: value,
            questionCount: value,
            timePerQuestion: value,
            teamCount: value
        )
    }
}

struct GameConfigDTOStub: GameConfigDTO {
    var gamePlaysPerAd: Int
    var questionCount: Int
    var timePerQuestion: Int
    var teamCount: Int
}
