import Foundation

public protocol GameDetailAnalyticsUsecase {
    func sendEvent(_ event: GameDetailAnalyticsEvent) async
}
