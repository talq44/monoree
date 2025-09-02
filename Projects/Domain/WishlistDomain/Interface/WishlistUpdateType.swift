import Foundation

public enum WishlistUpdateType {
    case add(WishListItem)
    case delete(id: String)
}
