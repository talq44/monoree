//
//  ListItemViewState.swift
//  DesignSystem
//
//  Created by 박창규 on 11/30/24.
//

import Foundation

public struct ListItem: Equatable {
    let id: Int
    let imageURL: String
    let name: String
    let isBookmarked: Bool
    
    public init(
        id: Int,
        imageURL: String,
        name: String,
        isBookmarked: Bool
    ) {
        self.id = id
        self.imageURL = imageURL
        self.name = name
        self.isBookmarked = isBookmarked
    }
}
