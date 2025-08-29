/// Post Score event. Log this event when the user posts a score in your gaming app. This event can help you understand how users are actually performing in your game and it can help you correlate high scores with certain audiences or behaviors.
/// - firebase: https://firebase.google.com/docs/reference/android/com/google/firebase/analytics/FirebaseAnalytics.Event#POST_SCORE()
public struct PostScore: Codable {
    public var score: Int
    public var character: String?
    
    public init(score: Int, character: String?) {
        self.score = score
        self.character = character
    }
}
