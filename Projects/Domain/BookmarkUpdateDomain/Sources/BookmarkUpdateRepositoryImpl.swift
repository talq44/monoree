import Foundation

import BookmarkUpdateDomainInterface

import LocalDataCoreInterface

final class BookmarkUpdateRepositoryImpl: BookmarkUpdateRepository {
    
    private let localDataSource: LocalDataProtocol
    
    init(localDataSource: LocalDataProtocol) {
        self.localDataSource = localDataSource
    }
    
    func update(
        _ request: BookmarkUpdateRequest
    ) -> Result<BookmarkUpdateResponse, BookmarkUpdateError> {
        return .failure(.unKnown)
    }
}

struct BookmarkUpdateRequestDTOImpl: BookmarkUpdateRequestDTO {
    var id: Int
    var isAdd: Bool
    var name: String
    var avatarUrl: String
}
