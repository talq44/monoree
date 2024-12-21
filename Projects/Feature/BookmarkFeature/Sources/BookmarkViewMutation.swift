//
//  BookmarkViewMutation.swift
//  BookmarkFeature
//
//  Created by 박창규 on 12/2/24.
//

import Foundation

enum BookmarkViewMutation {
    case setFirst
    case setEmpty
    case setLoading
    case setList(items: [BookmarkViewItem])
    case updateList(id: Int, isBookmarked: Bool)
    case setError(message: String)
}
