import Foundation

import SearchListDomainInterface
import UserAPICoreInterface
import AuthCoreInterface

import Swinject

final public class SearchListAssembly: Assembly {
    public init() { }
    public func assemble(container: Container) {
        container.register(
            SearchListUseCase.self
        ) { r in
            let userAPI = r.resolve(UserAPIProtocol.self)!
            let authCore = r.resolve(AuthCoreProtocol.self)!
            let repository = SearchListRepositoryImpl(
                remoteDatasource: userAPI,
                authDatasource: authCore
            )
            
            return SearchListUseCaseImpl(repository: repository)
        }
    }
}
