import Foundation

/// E-Commerce Add To Wishlist event. This event signifies that an item was added to a wishlist. Use this event to identify popular gift items. Note: If you supply the VALUE parameter, you must also supply the CURRENCY parameter so that revenue metrics can be computed accurately. Params:
/// - firebase: https://firebase.google.com/docs/reference/android/com/google/firebase/analytics/FirebaseAnalytics.Event#ADD_TO_WISHLIST()
public struct AddToWishlist: Codable {
    public let items: [ListItem]
    public init(items: [ListItem]) {
        self.items = items
    }
}
