//
//  FakeBookmarkUpdateUseCase.swift
//  BookmarkFeature
//
//  Created by 박창규 on 12/3/24.
//

import Foundation
import Combine

import BookmarkUpdateDomainInterface

final class FakeBookmarkUpdateUseCase: BookmarkUpdateUseCase {
    var bookmarkUpdate: AnyPublisher<any BookmarkUpdateOutput, Never> = Just(BookmarkUpdateOutputImpl(id: 1, isBookMark: true)).eraseToAnyPublisher()
    
    func execute(
        _ input: any BookmarkUpdateInput
    ) -> Result<any BookmarkUpdateOutput, BookmarkUpdateError> {
        return .success(BookmarkUpdateOutputImpl(
            id: input.id,
            isBookMark: input.isAdd
        ))
    }
}

struct BookmarkUpdateOutputImpl: BookmarkUpdateOutput {
    var id: Int
    var isBookMark: Bool
}
