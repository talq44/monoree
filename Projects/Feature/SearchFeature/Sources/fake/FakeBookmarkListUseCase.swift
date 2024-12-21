//
//  FakeBookmarkListUseCase.swift
//  SearchFeature
//
//  Created by 박창규 on 12/1/24.
//

import Foundation

import BookmarkListDomainInterface

final class FakeBookmarkListUseCase: BookmarkListUseCase {
    private let count: Int
    
    init(count: Int) {
        self.count = count
    }
    
    func execute(
        _ input: any BookmarkListInput
    ) -> Result<any BookmarkListOutput, BookmarkListError> {
        let max = count
        let count = Int.random(in: 1...max) // 무작위 개수
        let list = Array(0...max).shuffled().prefix(count).sorted()
        
        return .success(BookmarkListOutputImpl(
            items: list.map { BookmarkListItemImpl.mock(id: $0) }
        ))
    }
    
    func execute() -> Result<any BookmarkListOutput, BookmarkListError> {
        
        let max = count
        let count = Int.random(in: 1...max) // 무작위 개수
        let list = Array(0...max).shuffled().prefix(count).sorted()
        
        return .success(BookmarkListOutputImpl(
            items: list.map { BookmarkListItemImpl.mock(id: $0) }
        ))
    }
}

struct BookmarkListItemImpl: BookmarkListItem {
    var id: Int
    var login: String
    var avatarUrl: String
    
    static func mock(id: Int) -> Self {
        BookmarkListItemImpl(
            id: id,
            login: "login_\(id)",
            avatarUrl: "avatarUrl_\(id)"
        )
    }
}

struct BookmarkListOutputImpl: BookmarkListOutput {
    var items: [any BookmarkListDomainInterface.BookmarkListItem]
}
