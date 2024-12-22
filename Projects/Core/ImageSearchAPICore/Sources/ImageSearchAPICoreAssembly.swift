import Foundation

import ImageSearchAPICoreInterface

import Swinject

final public class UserAPICoreAssembly: Assembly {
    public init(clientId: String, clientSecret: String) {
        Constants.Header.clientId = clientId
        Constants.Header.clientSecret = clientSecret
    }
    
    public func assemble(container: Swinject.Container) {
        container.register(
            ImageSearchAPIProtocol.self
        ) { _ in ImageSearchAPICoreImpl() }
    }
}
