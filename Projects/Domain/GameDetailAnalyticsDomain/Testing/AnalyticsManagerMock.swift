import AnalyticsCoreInterface
import Foundation

class AnalyticsManagerMock: AnalyticsManager {
    private(set) var setUserIdCalledWith: String?
    private(set) var sendEventCalledWith: AnalyticsEvent?
    private(set) var sendEventCallCount: Int = 0
    private(set) var setUserIdCallCount: Int = 0
    
    func setUserId(id: String?) {
        setUserIdCalledWith = id
        setUserIdCallCount += 1
    }
    
    func sendEvent(_ event: AnalyticsCoreInterface.AnalyticsEvent) {
        sendEventCalledWith = event
        sendEventCallCount += 1
    }
}
