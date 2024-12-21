//
//  BookmarkViewItem.swift
//  BookmarkFeature
//
//  Created by 박창규 on 12/2/24.
//

import Foundation

struct BookmarkViewItem: Identifiable, Equatable {
    let id: Int
    let name: String
    let imageURL: String
    var isBookmarked: Bool
}
