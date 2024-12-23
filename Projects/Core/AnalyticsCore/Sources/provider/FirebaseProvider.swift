import Foundation

import AnalyticsCoreInterface

final class FirebaseProvider: AnalyticsProtocol {
    func setUserId(id: String) {
        
    }
    
    func sendEvent(_ event: AnalyticsEvent) {
        guard let eventName = event.name else { return }
        print("FirebaseProvider: \(eventName)")
    }
}
