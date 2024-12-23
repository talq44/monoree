import Foundation

import ItemListInteractionDomainInterface

final class ItemListInteractionUseCaseImpl: ItemListIntercationUseCase {
    private let repository: ItemListInteractionRepository
    
    public init(repository: ItemListInteractionRepository) {
        self.repository = repository
    }
    
    func send(input: any ItemListInteractionInput) {
        guard input.items.count > 0 else { return }
        
        switch input.sendType {
        case .selectItem:
            self.repository.sendSelectItem(
                items: input.items,
                itemList: input.itemList
            )
            
        case .viewItemList:
            self.repository.sendViewItemList(
                items: input.items,
                itemList: input.itemList
            )
        }
    }
}
