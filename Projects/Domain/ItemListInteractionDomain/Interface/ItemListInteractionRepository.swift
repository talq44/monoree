import Foundation

import DomainModelsDomainInterface

public protocol ItemListInteractionRepository {
    func sendViewItemList(
        items: [ItemListItem],
        itemList: ItemListType
    )
    func sendSelectItem(
        items: [ItemListItem],
        itemList: ItemListType
    )
}
