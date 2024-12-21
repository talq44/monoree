//
//  BookmakrUpdateAssembly.swift
//  BookmarkUpdateDomain
//
//  Created by 박창규 on 12/1/24.
//

import Foundation

import BookmarkUpdateDomainInterface
import LocalDataCoreInterface

import Swinject

public class BookmarkUpdateAssembly: Assembly {
    public init() { }
    
    public func assemble(container: Container) {
        container.register(
            BookmarkUpdateUseCase.self
        ) { r in
            let local = r.resolve(LocalDataProtocol.self)!
            let repository = BookmarkUpdateRepositoryImpl(
                localDataSource: local
            )
            
            return BookmarkUpdateUseCaseImpl(
                repository: repository
            )
        }.inObjectScope(.container) // <- 싱글톤으로 하나만
    }
}
