import Foundation
import GameEntityDomainInterface

public struct AQLPayload {
    let bundle: Bundle
    let listUseCase: GameListUseCase
    let categoryListUseCase: CategoryListUseCase
    
    public init(
        bundle: Bundle,
        listUseCase: GameListUseCase,
        categoryListUseCase: CategoryListUseCase
    ) {
        self.bundle = bundle
        self.listUseCase = listUseCase
        self.categoryListUseCase = categoryListUseCase
    }
}
