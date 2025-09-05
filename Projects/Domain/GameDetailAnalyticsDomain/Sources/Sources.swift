import Foundation
import GameDetailAnalyticsDomainInterface
import AnalyticsCoreInterface

final actor GameDetailAnalyticsUsecaseImpl: GameDetailAnalyticsUsecase {
    private let analytics: AnalyticsManager
    
    func sendEvent(_ event: GameDetailAnalyticsEvent) async {
        
    }
}
