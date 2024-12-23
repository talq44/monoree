/// View Search Results event. Log this event when the user has been presented with the results of a search.
/// - firebase: https://firebase.google.com/docs/reference/android/com/google/firebase/analytics/FirebaseAnalytics.Event#VIEW_SEARCH_RESULTS()
public struct ViewSearchResults: Codable {
    public let search_term: String
    public init(search_term: String) {
        self.search_term = search_term
    }
}
