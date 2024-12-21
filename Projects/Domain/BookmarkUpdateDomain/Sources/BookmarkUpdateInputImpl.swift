import Foundation

import BookmarkUpdateDomainInterface

struct BookmarkUpdateInputImpl: BookmarkUpdateInput {
    let id: Int
    let isAdd: Bool
    let name: String
    let avatarUrl: String
}
