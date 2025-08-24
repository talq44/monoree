import Foundation
import AnalyticsCoreInterface
import FirebaseAnalytics

final class FirebaseProvider: AnalyticsProtocol {
    init() { }
    
    func setUserId(id: String?) {
        Analytics.setUserID(id)
    }
    
    func sendEvent(_ event: AnalyticsEvent) {
        guard let name = event.name else { return }
        
        let parameters = event.parameters
        
        Analytics.logEvent(name, parameters: parameters)
    }
}
