import Foundation

import ItemListInteractionDomainInterface

final class ItemListInteractionUseCaseImpl: ItemListIntercationUseCase {
    private let repository: ItemListIntercationRepository
    
    public init(repository: ItemListIntercationRepository) {
        self.repository = repository
    }
    
    func send(input: any ItemListIntercationInput) {
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
