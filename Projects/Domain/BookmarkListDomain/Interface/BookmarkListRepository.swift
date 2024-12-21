//
//  BookmarkListRepository.swift
//  BookmarkListDomainInterface
//
//  Created by 박창규 on 11/29/24.
//

import Foundation

public protocol BookmarkListRepository {
    func fetch(
        _ request: BookmarkListRequest
    ) -> Result<BookmarkListResponse, BookmarkListError>
}
