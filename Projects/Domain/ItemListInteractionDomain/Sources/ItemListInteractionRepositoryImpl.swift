import Foundation

import DomainModelsDomainInterface
import ItemListInteractionDomainInterface

final class ItemListInteractionRepositoryImplementation: ItemListInteractionRepository {
    
    func sendViewItemList(
        items: [any ItemListInteractionDomainInterface.ItemListItem],
        itemList: any ItemList
    ) {
        self.fakeSend(
            items: items,
            itemListId: itemList.itemListId,
            itemListName: itemList.itemListId
        )
    }
    
    func sendSelectItem(
        items: [any ItemListInteractionDomainInterface.ItemListItem],
        itemList: any ItemList
    ) {
        self.fakeSend(
            items: items,
            itemListId: itemList.itemListId,
            itemListName: itemList.itemListId
        )
    }
    
    private func fakeSend(
        items: [any ItemListItem],
        itemListId: String?,
        itemListName: String?
    ) {
        print("items \(items)")
        print("itemListId \(itemListId ?? "")")
        print("itemListName \(itemListName ?? "")")
    }
}
