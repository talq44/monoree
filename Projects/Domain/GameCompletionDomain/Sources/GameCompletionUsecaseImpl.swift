import Foundation
import GameCompletionDomainInterface
import RemoteConfigCoreInterface
import AnalyticsCoreInterface

final class GameCompletionUsecaseImpl: GameCompletionUseCase {
    private let analytics: AnalyticsCoreInterface.AnalyticsProtocol
    private let remoteConfig: RemoteConfigCoreInterface.GameConfigManager
    
    // TODO: MVP에선 LocalData에 저장하도록 구현
    private var playCount: Int = 0
    
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
        playCount += 1
        sendAnalytics(score: input.score, gameName: input.gameName)
        
        guard playCount >= 3 else {
            return .none
        }
        
        playCount = 0
        
        return .showFullScreenAd
    }
}

// MARK: - Analytics
extension GameCompletionUsecaseImpl {
    private func sendAnalytics(score: Int, gameName: String) {
        analytics.sendEvent(.post_score(PostScore(
            score: score,
            character: gameName
        )))
    }
}
