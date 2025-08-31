import Foundation
import GameCompletionDomainInterface
import RemoteConfigCoreInterface
import AnalyticsCoreInterface
import LocalDataCoreInterface

final class GameCompletionUsecaseImpl: GameCompletionUseCase {
    private let analytics: AnalyticsProtocol
    private let remoteConfig: GameConfigManager
    private let localData: GameLocalDataManager
    
    // TODO: MVP에선 LocalData에 저장하도록 구현
    private var playCount: Int = 0
    
    init(
        remoteConfig: any GameConfigManager,
        localData: any GameLocalDataManager,
        analytics: any AnalyticsProtocol
    ) {
        self.analytics = analytics
        self.localData = localData
        self.remoteConfig = remoteConfig
    }
    
    func completeGame(
        _ input: any GameCompletionInput
    ) async -> GameCompletionResultType {
        playCount += 1
        sendAnalytics(score: input.score, gameName: input.gameName)
        
        do {
            let perAd = try remoteConfig.fetchGame().gamePlaysPerAd
            
            guard perAd > 0 else { return .none }
            guard playCount >= perAd else {
                return .none
            }
            
            playCount = 0
            
            return .showFullScreenAd
            
        } catch {
            return .none
        }
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
