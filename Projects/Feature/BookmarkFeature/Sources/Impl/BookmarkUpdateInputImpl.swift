//
//  BookmarkUpdateInputImpl.swift
//  BookmarkFeature
//
//  Created by 박창규 on 12/3/24.
//

import Foundation

import BookmarkUpdateDomainInterface

struct BookmarkUpdateInputImpl: BookmarkUpdateInput {
    var id: Int
    var isAdd: Bool
    var name: String
    var avatarUrl: String
}
