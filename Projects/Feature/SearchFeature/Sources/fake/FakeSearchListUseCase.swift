//
//  FakeSearchListUseCase.swift
//  SearchFeature
//
//  Created by 박창규 on 12/1/24.
//

import Foundation

import SearchListDomainInterface

final class FakeSearchListUseCase: SearchListUseCase {
    private let count: Int
    
    init(count: Int) {
        self.count = count
    }
    
    func execute(
        _ input: any SearchListDomainInterface.SearchListInput
    ) async -> Result<any SearchListOutput, SearchListError> {
        return .success(SearchListOutputImpl(
            items: Array(0..<self.count)
                .map { SearchListItemImpl.mock(id: $0) }
        ))
    }
}

struct SearchListItemImpl: SearchListDomainInterface.SearchListItem {
    var id: Int
    var login: String
    var nodeId: String
    var avatarUrl: String
    
    static func mock(id: Int) -> Self {
        SearchListItemImpl(
            id: id,
            login: "login_\(id)",
            nodeId: "nodeId_\(id)",
            avatarUrl: "avatarUrl_\(id)"
        )
    }
}

struct SearchListOutputImpl: SearchListOutput {
    var items: [any SearchListDomainInterface.SearchListItem]
}
