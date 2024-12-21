//
//  BookmarkListUseCase.swift
//  BookmarkListDomainInterface
//
//  Created by 박창규 on 11/29/24.
//

import Foundation

public protocol BookmarkListUseCase {
    func execute(
        _ input: BookmarkListInput
    ) -> Result<BookmarkListOutput, BookmarkListError>
    
    func execute() -> Result<BookmarkListOutput, BookmarkListError>
}
