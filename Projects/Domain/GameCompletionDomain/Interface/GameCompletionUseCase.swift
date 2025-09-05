import Foundation
import RemoteConfigCoreInterface
import AnalyticsCoreInterface
import LocalDataCoreInterface

public protocol GameCompletionUseCase {
    init(
        remoteConfig: GameConfigManager,
        localData: GameLocalDataManager,
        analytics: AnalyticsManager
    )
    
    func completeGame(
        _ input: any GameCompletionInput
    ) async -> GameCompletionResultType
}
