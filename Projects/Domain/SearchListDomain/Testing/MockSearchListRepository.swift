import Foundation

import SearchListDomainInterface

final class MockSearchListRepository: SearchListRepository {
    private var totalCount: Int = 100
    private var itemCount: Int = 30
    private var isError: Bool = false
    
    func setUp(
        totalCount: Int = 100,
        itemCount: Int = 30,
        isError: Bool = false
    ) {
        self.totalCount = totalCount
        self.itemCount = itemCount
        self.isError = isError
    }
    
    func fetch(
        _ request: any SearchListDomainInterface.SearchListRequest
    ) async -> Result<any SearchListResponse, SearchListError> {
        guard !isError else {
            return .failure(.unKnown)
        }
        
        let items: [StubSearchListItem] = Array(1...itemCount).map { index in
            return StubSearchListItem.mock(id: index)
        }
        
        return .success(StubSearchListResponse(
            totalCount: self.totalCount,
            items: items
        ))
    }
}
