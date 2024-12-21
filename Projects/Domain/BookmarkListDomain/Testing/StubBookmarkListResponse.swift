import Foundation

import BookmarkListDomainInterface

struct StubBookmarkListResponse: BookmarkListResponse {
    var items: [any BookmarkListDomainInterface.BookmarkListItem]
}
