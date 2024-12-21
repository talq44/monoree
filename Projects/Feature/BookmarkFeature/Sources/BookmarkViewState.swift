//
//  BookmarkViewState.swift
//  BookmarkFeature
//
//  Created by 박창규 on 12/2/24.
//

import Foundation

enum BookmarkViewState: Equatable {
    case first
    case loading
    case results(items: [BookmarkViewItem])
    case noResults
    case error(message: String)
}
