/// Select Content event. This general purpose event signifies that a user has selected some content of a certain type in an app. The content can be any object in your app. This event can help you identify popular content and categories of content in your app.
/// - firebase: https://firebase.google.com/docs/reference/android/com/google/firebase/analytics/FirebaseAnalytics.Event#SELECT_CONTENT()
public struct SelectContent: Codable {
    public let content_type: String
    public let item_id: String
    
    public init(content_type: String, item_id: String) {
        self.content_type = content_type
        self.item_id = item_id
    }
}
