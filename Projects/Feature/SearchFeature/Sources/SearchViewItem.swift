//
//  SearchViewItem.swift
//  SearchFeature
//
//  Created by 박창규 on 12/1/24.
//

import Foundation

struct SearchViewItem: Identifiable, Equatable {
    let id: Int
    let name: String
    let imageURL: String
    var isBookmarked: Bool
}
