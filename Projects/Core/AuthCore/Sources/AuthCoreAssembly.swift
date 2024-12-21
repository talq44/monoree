//
//  AuthCoreAssembly.swift
//  AuthCore
//
//  Created by 박창규 on 12/5/24.
//

import Foundation

import AuthCoreInterface

import Swinject

public class AuthCoreAssembly: Assembly {
    private let githubToken: String
    public init(githubToken: String) {
        self.githubToken = githubToken
    }
    public func assemble(container: Container) {
        container.register(
            AuthCoreProtocol.self
        ) { _ in
            return AuthCoreProtocolImpl(githubToken: self.githubToken)
        }
    }
}
