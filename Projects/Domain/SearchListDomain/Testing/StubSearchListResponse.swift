//
//  StubSearchListResponse.swift
//  SearchListDomainTesting
//
//  Created by 박창규 on 11/29/24.
//

import Foundation

import SearchListDomainInterface

struct StubSearchListResponse: SearchListResponse {
    var totalCount: Int
    
    var items: [any SearchListDomainInterface.SearchListItem]
}
