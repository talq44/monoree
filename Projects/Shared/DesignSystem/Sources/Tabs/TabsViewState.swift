//
//  TabsViewState.swift
//  DesignSystem
//
//  Created by 박창규 on 11/30/24.
//

import Foundation

public struct TabsViewState {
    let items: [TabsViewItem]
    
    public init(items: [TabsViewItem]) {
        self.items = items
    }
    
    static var mock2Item: TabsViewState {
        .init(items: [
            TabsViewItem(title: "Tab 1", isSelected: true),
            TabsViewItem(title: "Tab 2", isSelected: false)
        ])
    }
    
    static var mock4Item: TabsViewState {
        .init(items: [
            TabsViewItem(title: "Tab 1", isSelected: true),
            TabsViewItem(title: "Tab 2", isSelected: true),
            TabsViewItem(title: "Tab 3", isSelected: false),
            TabsViewItem(title: "Tab 4", isSelected: false),
        ])
    }
}
