import Foundation

import BookmarkListDomainInterface

struct BookmarkListResponseImpl: BookmarkListResponse {
    let items: [any BookmarkListDomainInterface.BookmarkListItem]
}
