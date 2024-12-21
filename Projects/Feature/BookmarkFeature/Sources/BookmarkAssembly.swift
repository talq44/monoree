//
//  BookmarkAssembly.swift
//  BookmarkFeature
//
//  Created by 박창규 on 12/2/24.
//

import Foundation

import BookmarkListDomainInterface
import BookmarkUpdateDomainInterface
import BookmarkFeatureInterface

import Swinject

final public class BookmarkAssembly: Assembly {
    
    public init() { }
    
    public func assemble(container: Swinject.Container) {
        container.register(
            BookmarkOutput.self
        ) { r in
            let bookmarkListUseCase = r.resolve(BookmarkListUseCase.self)!
            let bookmarkUpdateUseCase = r.resolve(BookmarkUpdateUseCase.self)!
            
            let reactor = BookmarkViewReactor(
                bookmarkListUseCase: bookmarkListUseCase,
                bookmarkUpdateUseCase: bookmarkUpdateUseCase
            )
            
            let viewController = BookmarkViewController(reactor: reactor)
                        
            return BookmarkOutput(
                viewController: viewController
            )
        }
    }
}
