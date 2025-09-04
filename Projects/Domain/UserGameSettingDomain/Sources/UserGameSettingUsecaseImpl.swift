import Foundation
import UserGameSettingDomainInterface
import LocalDataCoreInterface
import RemoteConfigCoreInterface

final actor UserGameSettingUsecaseImpl: UserGameSettingUsecase {
    private let remoteConfig: GameConfigManager
    private let localData: UserLocalDataManager
    
    public init(
        remoteConfig: GameConfigManager,
        localData: UserLocalDataManager
    ) {
        self.remoteConfig = remoteConfig
        self.localData = localData
    }
    
    func getConfig() async -> UserGameSettingDomainInterface.UserGameSettingItem {
        <#code#>
    }
    
    func setQuestionCount(_ count: Int) async {
        <#code#>
    }
    
    func setTimePerQuestion(_ time: UserGameSettingDomainInterface.UserGameTimePerQuestionType) async {
        <#code#>
    }
    
    func setTeamCount(_ count: Int) async {
        <#code#>
    }
}
