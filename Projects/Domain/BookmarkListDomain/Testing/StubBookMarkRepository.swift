import Foundation

import BookmarkListDomainInterface

final class StubBookMarkListRepository: BookmarkListRepository {
    private var searchWord: String?
    private var searchWordContains: Bool = false
    private var isError: Bool = false
    private var returnCount: Int = 10
    
    func setUp(
        searchWord: String,
        searchWordContains: Bool,
        isError: Bool = false,
        returnCount: Int = 10
    ) {
        self.searchWord = searchWord
        self.searchWordContains = searchWordContains
        self.isError = isError
        self.returnCount = returnCount
    }
    
    func fetch(
        _ request: any BookmarkListRequest
    ) -> Result<any BookmarkListResponse, BookmarkListError> {
        guard !isError else { return .failure(.unKnown) }
        
        var items: [StubBookmarkListItem] = []
        
        if self.searchWordContains {
            items.append(StubBookmarkListItem.mock(
                id: 0,
                name: self.searchWord
            ))
        } else {
            items.append(StubBookmarkListItem.mock(
                id: 0
            ))
        }
        
        for index in 1..<returnCount {
            let item = StubBookmarkListItem.mock(id: index)
            items.append(item)
        }
        
        return .success(StubBookmarkListResponse(items: items))
    }
}
