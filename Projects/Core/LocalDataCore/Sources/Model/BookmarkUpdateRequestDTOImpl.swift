import Foundation

import LocalDataCoreInterface

struct BookmarkUpdateRequestDTOImpl: BookmarkUpdateRequestDTO {
    let id: Int
    let isAdd: Bool
    let name: String
    let avatarUrl: String
}
