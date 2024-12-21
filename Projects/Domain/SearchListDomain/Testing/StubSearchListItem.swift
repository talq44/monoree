//
//  StubSearchListItem.swift
//  SearchListDomainTesting
//
//  Created by 박창규 on 11/29/24.
//

import Foundation

import SearchListDomainInterface

import Fakery

struct StubSearchListItem: SearchListItem {
    var id: Int
    var login: String
    var nodeId: String
    var avatarUrl: String
    
    static func mock(id: Int) -> Self {
        let fake = Faker()
        
        return StubSearchListItem(
            id: id,
            login: fake.name.firstName(),
            nodeId: "\(fake.number.increasingUniqueId())",
            avatarUrl: fake.internet.image()
        )
    }
}
