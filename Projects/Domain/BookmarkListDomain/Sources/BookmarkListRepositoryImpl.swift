import Foundation

import BookmarkListDomainInterface
import LocalDataCoreInterface

final class BookmarkListRepositoryImpl: BookmarkListRepository {
    private let localDatasource: LocalDataProtocol?
    
    init(localDatasource: LocalDataProtocol?) {
        self.localDatasource = localDatasource
    }
    
    func fetch(
        _ request: any BookmarkListRequest
    ) -> Result<any BookmarkListResponse, BookmarkListError> {
        let request = BookmarkListRequestDTOImpl()
        return .failure(.unKnown)
    }
    
    private func toDomain(
        _ response: BookmarkListResponseDTO
    ) -> BookmarkListResponse {
        return BookmarkListResponseImpl(
            items: response.items.map {
                return BookmarkListItemImpl(
                    id: $0.id,
                    login: $0.name,
                    avatarUrl: $0.avatarUrl
                )
            }
        )
    }
}

struct BookmarkListRequestDTOImpl: BookmarkListRequestDTO { }
