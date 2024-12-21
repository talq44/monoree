import Foundation

import BookmarkUpdateDomainInterface

struct BookmarkUpdateResponseImpl: BookmarkUpdateResponse {
    let id: Int
    let isBookMark: Bool
}
