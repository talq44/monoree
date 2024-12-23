import Foundation

public protocol AnalyticsProtocol {
    func setUserId(id: String)
    func sendEvent(_ event: AnalyticsEvent)
}
