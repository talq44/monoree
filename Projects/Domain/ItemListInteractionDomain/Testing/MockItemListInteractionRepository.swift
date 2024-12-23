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
    
    func sendViewItemList(_ input: any ItemListInteractionInput) {
        self.sendViewItemListItems += input.items
    }
    
    func sendSelectItem(_ input: any ItemListInteractionInput) {   
        self.sendSelectItemItems += input.items
    }
}
