import Foundation

/// View Item event. This event signifies that a user has viewed an item. Use the appropriate parameters to contextualize the event. Use this event to discover the most popular items viewed in your app. Note: If you supply the VALUE parameter, you must also supply the CURRENCY parameter so that revenue metrics can be computed accurately.
/// - firebase: https://firebase.google.com/docs/reference/android/com/google/firebase/analytics/FirebaseAnalytics.Event#VIEW_ITEM()
public struct ViewItem: Codable {
    public let items: [DetailItem]
    
    public init(items: [DetailItem]) {
        self.items = items
    }
}
