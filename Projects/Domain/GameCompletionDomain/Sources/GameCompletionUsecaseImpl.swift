import Foundation
import GameCompletionDomainInterface
import RemoteConfigCoreInterface
import AnalyticsCoreInterface

final class GameCompletionUsecaseImpl: GameCompletionUseCase {
    private let analytics: AnalyticsCoreInterface.AnalyticsProtocol
    private let remoteConfig: RemoteConfigCoreInterface.GameConfigManager
    
    init(
        remoteConfig: any RemoteConfigCoreInterface.GameConfigManager,
        analytics: AnalyticsCoreInterface.AnalyticsProtocol
    ) {
        self.analytics = analytics
        self.remoteConfig = remoteConfig
    }
    
    func completeGame(
        _ input: GameCompletionInput
    ) async -> GameCompletionResultType {
        analytics.sendEvent(.post_score(PostScore(
            score: input.score,
            character: input.gameName
        )))
        
        return .none
    }
}
