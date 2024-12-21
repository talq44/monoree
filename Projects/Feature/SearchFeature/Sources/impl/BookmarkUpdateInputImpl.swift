//
//  BookmarkUpdateInputImpl.swift
//  SearchFeature
//
//  Created by 박창규 on 12/1/24.
//

import Foundation

import BookmarkUpdateDomainInterface

struct BookmarkUpdateInputImpl: BookmarkUpdateInput {
    var id: Int
    var isAdd: Bool
    var name: String
    var avatarUrl: String
}
