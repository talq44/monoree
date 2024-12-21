//
//  SearchViewAction.swift
//  SearchFeature
//
//  Created by 박창규 on 11/30/24.
//

import Foundation

enum SearchViewAction {
    case refresh(query: String)
    case inputSearch(query: String)
    case didSelectSearch(query: String)
    case selectBookMark(id: Int)
    case willDisplayLast(query: String)
}
