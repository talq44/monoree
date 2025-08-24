import Foundation

import BookmarkListDomainInterface
import LocalDataCoreInterface

import Swinject

public class BookmarkListAssembly: Assembly {
    public init() { }
    
    public func assemble(container: Container) {
        container.register(
            BookmarkListUseCase.self
        ) { r in
            let local = r.resolve(LocalDataProtocol.self)
            let repository = BookmarkListRepositoryImpl(
                localDatasource: local
            )
            return BookmarkListUseCaseImpl(repository: repository)
        }
    }
}
