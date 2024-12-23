import Foundation

public protocol ItemListInteractionRepository {
    func sendViewItemList(
        items: [ItemListItem],
        itemList: ItemList
    )
    func sendSelectItem(
        items: [ItemListItem],
        itemList: ItemList
    )
}
