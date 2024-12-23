import Foundation

import ItemListInteractionDomainInterface

final class ItemListInteractionUseCaseImpl: ItemListIntercationUseCase {
    private let repository: ItemListInteractionRepository
    
    public init(repository: ItemListInteractionRepository) {
        self.repository = repository
    }
    
    func send(_ input: any ItemListInteractionInput) {
        guard input.items.count > 0 else { return }
        
        switch input.sendType {
        case .selectItem:
            self.repository.sendSelectItem(input)
            
        case .viewItemList:
            self.repository.sendViewItemList(input)
        }
    }
}
