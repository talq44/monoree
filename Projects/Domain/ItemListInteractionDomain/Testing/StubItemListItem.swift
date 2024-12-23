import Foundation

import ItemListInteractionDomainInterface

struct StubItemListItem: ItemListItem {
    var id: String
    var name: String
    var index: Int
    
    static func mock(
        id: String? = nil,
        name: String? = nil,
        index: Int? = nil
    ) -> StubItemListItem {
        StubItemListItem(
            id: id ?? "",
            name: name ?? "Stub Item",
            index: index ?? 0
        )
    }
}
