import Foundation

import AuthCoreInterface

final class AuthCoreProtocolImpl: AuthCoreProtocol {
    private let githubToken: String
    
    init(githubToken: String) {
        self.githubToken = githubToken
    }
    
    func userInfo() -> any AuthCoreOutput {
        return AuthOutputImpl(githubToken: self.githubToken)
    }
}
