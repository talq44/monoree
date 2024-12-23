import Foundation

import ViewItemDomainInterface

final class ViewItemUseCaseImplementation: ViewItemUseCase {
    private let repository: ViewItemRepository
    
    init(repository: ViewItemRepository) {
        self.repository = repository
    }
    
    func send(_ input: any ViewItemDomainInterface.ViewItemInput) {
        guard input.items.count > 0 else { return }
        self.repository.send(input)
    }
}
