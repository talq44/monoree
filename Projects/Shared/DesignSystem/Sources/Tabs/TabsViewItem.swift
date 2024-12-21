//
//  TabsViewItem.swift
//  DesignSystem
//
//  Created by 박창규 on 11/30/24.
//

import Foundation

public struct TabsViewItem {
    let title: String
    let isSelected: Bool
    
    public init(title: String, isSelected: Bool) {
        self.title = title
        self.isSelected = isSelected
    }
}
