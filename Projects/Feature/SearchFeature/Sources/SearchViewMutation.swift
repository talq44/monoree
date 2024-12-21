//
//  SearchViewMutation.swift
//  SearchFeature
//
//  Created by 박창규 on 11/30/24.
//

import Foundation

enum SearchViewMutation {
    case setFirst
    case setLoading
    case setSearchList(items: [SearchViewItem], isMore: Bool)
    case updateSearchList(id: Int, isBookmarked: Bool)
    case setError(message: String)
    case setEmpty
}
