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
        do {
            let response = try self.localDataSource.patch_bookmarks(
                request: BookmarkUpdateRequestDTOImpl(
                    id: request.id,
                    isAdd: request.isAdd,
                    name: request.name,
                    avatarUrl: request.avatarUrl
                )
            )
            
            return .success(BookmarkUpdateResponseImpl(
                id: response.id,
                isBookMark: response.isBookmarked
            ))
            
        } catch {
            return .failure(.unKnown)
        }
    }
}

struct BookmarkUpdateRequestDTOImpl: BookmarkUpdateRequestDTO {
    var id: Int
    var isAdd: Bool
    var name: String
    var avatarUrl: String
}
