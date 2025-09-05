import Foundation
import GameCompletionDomainInterface
import AnalyticsCoreInterface

final class AnalyticsCoreMock: AnalyticsManager {
    internal var callPostScore: Bool = false
    
    func setUserId(id: String?) { }
    
    func sendEvent(_ event: AnalyticsCoreInterface.AnalyticsEvent) {
        guard event.name == "post_score" else {
            return
        }
        
        callPostScore = true
    }
}
