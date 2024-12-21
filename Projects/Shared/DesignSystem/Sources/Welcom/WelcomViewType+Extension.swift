//
//  WebcomViewType+Extension.swift
//  DesignSystem
//
//  Created by 박창규 on 12/1/24.
//

import Foundation

extension WelcomViewType {
    var title: String {
        switch self {
        case .search:
            return "검색"
        case .bookmark:
            return "즐겨찾기"
        }
    }
    
    var subTitle: String {
        switch self {
        case .search:
            return "검색을 통해 원하는 사람을 찾아보세요."
        case .bookmark:
            return "즐겨찾기에 담은 사람들을 찾아보세요."
        }
    }
    
    var imageName: String {
        switch self {
        case .search:
            return "party.popper"
        case .bookmark:
            return "fireworks"
        }
    }
}
