import Foundation
import RemoteConfigCoreInterface
import AnalyticsCoreInterface

public protocol GameCompletionUseCase {
    init(remoteConfig: GameConfigManager, analytics: AnalyticsProtocol)
    
    func completeGame(
        _ input: GameCompletionInput
    ) async -> GameCompletionResultType
}
