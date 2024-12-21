import Foundation

import LocalDataCoreInterface

struct BookmarkUpdateResponseDTOImpl: BookmarkUpdateResponseDTO {
    let id: Int
    let isBookmarked: Bool
}
