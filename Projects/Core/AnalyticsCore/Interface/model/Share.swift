/// Share event. Apps with social features can log the Share event to identify the most viral content.
/// - firebase : https://firebase.google.com/docs/reference/android/com/google/firebase/analytics/FirebaseAnalytics.Event#SHARE()
public struct Share: Codable {
    public let content_type: String
    public let item_id: String
    public let method: String
    
    public init(content_type: String, item_id: String, method: String) {
        self.content_type = content_type
        self.item_id = item_id
        self.method = method
    }
}
