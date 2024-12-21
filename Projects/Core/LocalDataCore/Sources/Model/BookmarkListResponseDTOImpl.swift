import Foundation

import LocalDataCoreInterface

import RealmSwift

struct BookmarkListResponseDTOImpl: BookmarkListResponseDTO {
    let items: [any LocalDataCoreInterface.BookmarkItemDTO]
}
