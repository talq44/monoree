//
//  MainTabType.swift
//  Remember
//
//  Created by 박창규 on 12/3/24.
//

import Foundation

enum MainTabType: String, Equatable, CaseIterable {
    case search
    case bookmark
    
    var name: String {
        switch self {
        case .search:
            return "API"
        case .bookmark:
            return "Local"
        }
    }
    
    var pageTitle: String {
        switch self {
        case .search: return "Github Stars Search"
        case .bookmark: return "Github Stars Bookmark"
        }
    }
}
