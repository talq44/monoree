import Foundation

public protocol BookmarkListItem {
    var id: Int { get }
    var login: String { get }
    var avatarUrl: String { get }
}
