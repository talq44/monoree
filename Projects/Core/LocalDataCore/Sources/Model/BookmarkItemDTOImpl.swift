import Foundation

import LocalDataCoreInterface

import RealmSwift

class BookmarkItemDTOImpl: RealmSwift.Object, BookmarkItemDTO {
    @Persisted(primaryKey: true) var id: Int
    @Persisted var name: String
    @Persisted var avatarUrl: String
}
