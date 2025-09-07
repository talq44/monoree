import Foundation

/// View Item List event. Log this event when a user sees a list of items or offerings
/// - firebase: https://firebase.google.com/docs/reference/android/com/google/firebase/analytics/FirebaseAnalytics.Event#VIEW_ITEM_LIST()
public struct ViewItemList: Codable {
    public let items: [SimpleItem]
    public let item_list_id: String?
    public let item_list_name: String?
    
    public init(items: [SimpleItem], item_list_id: String?, item_list_name: String?) {
        self.items = items
        self.item_list_id = item_list_id
        self.item_list_name = item_list_name
    }
}
