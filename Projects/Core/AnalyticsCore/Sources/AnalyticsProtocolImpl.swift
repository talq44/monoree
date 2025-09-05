import Foundation
import AnalyticsCoreInterface

final class AnalyticsProtocolImpl: AnalyticsManager {
    
    private let providers: [AnalyticsManager]
    
    init(providers: [AnalyticsProviderType]) {
        self.providers = providers.map { $0.provider }
    }
    
    func setUserId(id: String?) {
        providers.forEach {
            $0.setUserId(id: id)
        }
    }
    
    func sendEvent(_ event: AnalyticsEvent) {
        providers.forEach {
            $0.sendEvent(event)
        }
    }
}
