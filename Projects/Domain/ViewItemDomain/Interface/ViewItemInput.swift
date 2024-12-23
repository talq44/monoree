import DomainModelsDomainInterface
/// https://firebase.google.com/docs/reference/android/com/google/firebase/analytics/FirebaseAnalytics.Event#VIEW_ITEM()
public protocol ViewItemInput {
    var items: [DetailItem] { get }
    var itemList: ItemList { get }
}
