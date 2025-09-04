import Foundation
import UserGameSettingDomainInterface
import LocalDataCoreInterface
import RemoteConfigCoreInterface

final actor UserGameSettingUsecaseImpl: UserGameSettingUsecase {
    private enum Constants {
        static let questionCount: Int = 10
        static let timePerQuestion: Int = 5
        static let teamCount: Int = 1
    }
    
    private let remoteConfig: GameConfigManager
    private let localData: UserLocalDataManager
    
    public init(
        remoteConfig: GameConfigManager,
        localData: UserLocalDataManager
    ) {
        self.remoteConfig = remoteConfig
        self.localData = localData
    }
    
    func getConfig() async -> UserGameSettingItem {
        let defaultConfig = getDefaultConfig()
        
        let questionCount = await localData.questionCount()
        let timePerQuestion = await localData.timePerQuestion()
        let teamCount = await localData.teamCount()
        
        return UserGameSettingItem(
            questionCount: questionCount ?? defaultConfig.questionCount,
            timePerQuestion: UserGameTimePerQuestionType(
                second: timePerQuestion
            ) ?? defaultConfig.timePerQuestion,
            teamCount: teamCount ?? defaultConfig.teamCount
        )
    }
    
    private func getDefaultConfig() -> UserGameSettingItem {
        do {
            let config = try remoteConfig.fetchGame()
            
            return UserGameSettingItem(
                questionCount: config.questionCount,
                timePerQuestion: UserGameTimePerQuestionType(
                    second: config.timePerQuestion
                ),
                teamCount: config.teamCount
            )
        } catch {
            return UserGameSettingItem(
                questionCount: Constants.questionCount,
                timePerQuestion: UserGameTimePerQuestionType(
                    second: Constants.timePerQuestion
                ),
                teamCount: Constants.teamCount
            )
        }
    }
    
    func setQuestionCount(_ count: Int) async {
        await localData.setQuestionCount(count)
    }
    
    func setTimePerQuestion(_ time: UserGameTimePerQuestionType) async {
        await localData.setTimePerQuestion(time.value)
    }
    
    func setTeamCount(_ count: Int) async {
        await localData.setTeamCount(count)
    }
}

extension UserGameTimePerQuestionType {
    var value: Int {
        switch self {
        case .second(let int):
            return int
        case .unlimited:
            return -1
        }
    }
}
