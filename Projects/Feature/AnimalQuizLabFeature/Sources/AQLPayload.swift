import GameEntityDomainInterface

public struct AQLPayload {
    let listUseCase: GameListUseCase
    let categoryListUseCase: CategoryListUseCase
    
    public init(listUseCase: GameListUseCase, categoryListUseCase: CategoryListUseCase) {
        self.listUseCase = listUseCase
        self.categoryListUseCase = categoryListUseCase
    }
}
