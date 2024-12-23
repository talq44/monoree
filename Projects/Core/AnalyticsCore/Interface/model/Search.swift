/// Search event. Apps that support search features can use this event to contextualize search operations by supplying the appropriate, corresponding parameters. This event can help you identify the most popular content in your
/// firebase: https://firebase.google.com/docs/reference/android/com/google/firebase/analytics/FirebaseAnalytics.Event#SEARCH()
public struct Search: Codable {
    public let search_term: String
    public init(search_term: String) {
        self.search_term = search_term
    }
}
