import Foundation

import BookmarkUpdateDomainInterface

struct BookmarkUpdateRequestImpl: BookmarkUpdateRequest {
    let id: Int
    let isAdd: Bool
    let name: String
    let avatarUrl: String
}
