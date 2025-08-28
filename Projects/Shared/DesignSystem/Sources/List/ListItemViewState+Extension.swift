//
//  ListItemViewState+Extension.swift
//  DesignSystem
//
//  Created by 박창규 on 11/30/24.
//

import Foundation

extension ListItem {
    static func mock(id: Int) -> ListItem {
        return ListItem(
            id: id,
            imageURL: "",
            name: "",
            isBookmarked: false
        )
    }
}
