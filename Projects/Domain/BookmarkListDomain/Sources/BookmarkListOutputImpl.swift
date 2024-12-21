import Foundation

import BookmarkListDomainInterface

struct BookmarkListOutputImpl: BookmarkListOutput  {
    var items: [any BookmarkListDomainInterface.BookmarkListItem]
}
