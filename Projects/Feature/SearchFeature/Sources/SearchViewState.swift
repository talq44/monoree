//
//  SearchViewState.swift
//  SearchFeature
//
//  Created by 박창규 on 11/30/24.
//

import Foundation

enum SearchViewState: Equatable {
    /// 최초 진입시 상태
    case first
    /// 검색 중
    case searching
    /// 검색 결과 없음
    case noResults
    /// 검색 결과 있음
    case results(items: [SearchViewItem])
    
    case error(message: String)
}

extension SearchViewState {
    var testCount: Int {
        switch self {
        case .noResults: return 0
        default:
            return 30
        }
    }
}
