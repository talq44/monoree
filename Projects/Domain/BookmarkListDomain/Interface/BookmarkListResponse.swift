//
//  BookmarkListResponse.swift
//  BookmarkListDomainInterface
//
//  Created by 박창규 on 11/29/24.
//

import Foundation

public protocol BookmarkListResponse {
    var items: [BookmarkListItem] { get }
}
