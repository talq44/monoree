//
//  ListItemViewState+Extension.swift
//  DesignSystem
//
//  Created by 박창규 on 11/30/24.
//

import Foundation

import Fakery

extension ListItem {
    
    static func mock(id: Int) -> ListItem {
        let fake = Faker()
        return ListItem(
            id: id,
            imageURL: fake.internet.image(),
            name: fake.name.lastName() + " " + fake.name.firstName(),
            isBookmarked: fake.number.randomBool()
        )
    }
}
