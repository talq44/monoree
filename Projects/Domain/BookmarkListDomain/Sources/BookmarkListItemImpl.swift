import Foundation

import BookmarkListDomainInterface

struct BookmarkListItemImpl: BookmarkListItem {
    let id: Int
    let login: String
    let avatarUrl: String
}
