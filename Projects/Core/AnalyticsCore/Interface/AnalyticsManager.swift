import Foundation

public protocol AnalyticsManager {
    func setUserId(id: String?)
    func sendEvent(_ event: AnalyticsEvent)
}
