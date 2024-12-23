import Foundation

public protocol ItemListIntercationRepository {
    func sendViewItemList(
        items: [ItemListItem],
        itemList: ItemList
    )
    func sendSelectItem(
        items: [ItemListItem],
        itemList: ItemList
    )
}
