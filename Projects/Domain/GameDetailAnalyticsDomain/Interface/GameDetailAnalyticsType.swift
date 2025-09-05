import Foundation

public enum GameDetailAnalyticsEvent {
    case add_to_wishlist(GameDetailItem)
    case action(GameDetailActionType)
    case play_item(GameDetailItem)
    case view_item(GameDetailItem)
}
