import Foundation

import ItemListInteractionDomainInterface

final class MockItemListInteractionRepository: ItemListInteractionRepository {
    
    private var sendViewItemListItems: [any ItemListItem] = []
    private var sendSelectItemItems: [any ItemListItem] = []
    
    public var sendViewItemListItemsCount: Int {
        return self.sendViewItemListItems.count
    }
    
    public var sendSelectItemItemsCount: Int {
        return self.sendSelectItemItems.count
    }
    
    func sendViewItemList(
        items: [any ItemListInteractionDomainInterface.ItemListItem],
        itemList: ItemListInteractionDomainInterface.ItemList
    ) {
        self.sendViewItemListItems += items
    }
    
    func sendSelectItem(
        items: [any ItemListInteractionDomainInterface.ItemListItem],
        itemList: ItemListInteractionDomainInterface.ItemList
    ) {
        self.sendSelectItemItems += items
    }
}
