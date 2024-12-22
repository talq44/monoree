//
//  MainTabViewState.swift
//  Remember
//
//  Created by 박창규 on 12/3/24.
//

import Foundation

struct MainTabViewState {
    let tabs = MainTabType.allCases
    var currentTab: MainTabType = .search
    var title: String = ""
}
