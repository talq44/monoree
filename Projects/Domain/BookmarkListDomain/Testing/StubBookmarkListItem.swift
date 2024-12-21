import Foundation

import BookmarkListDomainInterface

import Fakery

struct StubBookmarkListItem: BookmarkListItem {
    let id: Int
    let login: String
    let avatarUrl: String
    
    static func mock(id: Int, name: String? = nil) -> StubBookmarkListItem {
        let fake = Faker()
        return StubBookmarkListItem(
            id: id,
            login: name ?? fake.name.firstName(),
            avatarUrl: fake.internet.image()
        )
    }
}
