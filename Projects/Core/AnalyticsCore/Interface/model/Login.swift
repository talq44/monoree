/// Login event. Apps with a login feature can report this event to signify that a user has logged in.
/// firebase: https://firebase.google.com/docs/reference/android/com/google/firebase/analytics/FirebaseAnalytics.Event#LOGIN()
public struct Login: Codable {
    public let method: String
    public init(method: String) {
        self.method = method
    }
}
