import Foundation

import ItemListInteractionDomainInterface

final class ItemListInteractionRepositoryImplementation: ItemListInteractionRepository {
    func sendViewItemList(_ input: any ItemListInteractionInput) {
        
        self.fakeSend(
            items: input.items,
            itemListId: input.itemList.itemListId,
            itemListName: input.itemList.itemListId
        )
    }
    
    func sendSelectItem(_ input: any ItemListInteractionInput) {
        
        self.fakeSend(
            items: input.items,
            itemListId: input.itemList.itemListId,
            itemListName: input.itemList.itemListId
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
