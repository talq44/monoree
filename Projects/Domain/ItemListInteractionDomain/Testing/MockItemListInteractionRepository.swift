import Foundation

import ItemListInteractionDomainInterface

final class MockItemListInteractionRepository: ItemListInteractionRepository {
    func sendViewItemList(
        items: [any ItemListInteractionDomainInterface.ItemListItem],
        itemList: ItemListInteractionDomainInterface.ItemList
    ) {
        
    }
    
    func sendSelectItem(
        items: [any ItemListInteractionDomainInterface.ItemListItem],
        itemList: ItemListInteractionDomainInterface.ItemList
    ) {
        
    }
}
