/// Sign Up event. This event indicates that a user has signed up for an account in your app. The parameter signifies the method by which the user signed up. Use this event to understand the different behaviors between logged in and logged out users.
/// - firebase : https://firebase.google.com/docs/reference/android/com/google/firebase/analytics/FirebaseAnalytics.Event#SIGN_UP()
public struct SignUp: Codable {
    public let method: String
    public init(method: String) {
        self.method = method
    }
}
