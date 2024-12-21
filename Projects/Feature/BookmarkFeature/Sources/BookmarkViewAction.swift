//
//  BookmarkViewAction.swift
//  BookmarkFeature
//
//  Created by 박창규 on 12/2/24.
//

import Foundation

enum BookmarkViewAction {
    case refresh(query: String)
    case viewDidLoad
    case inputSearch(query: String)
    case didSelectSearch(query: String)
    case selectBookmark(id: Int)
}
