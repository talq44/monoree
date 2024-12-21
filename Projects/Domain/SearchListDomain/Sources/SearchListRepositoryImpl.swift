import Foundation

import SearchListDomainInterface
import UserAPICoreInterface
import AuthCoreInterface

final class SearchListRepositoryImpl: SearchListRepository {
    
    private let remoteDatasource: UserAPIProtocol
    private let authDatasource: AuthCoreProtocol
    
    init(
        remoteDatasource: UserAPIProtocol,
        authDatasource: AuthCoreProtocol
    ) {
        self.remoteDatasource = remoteDatasource
        self.authDatasource = authDatasource
    }
    
    func fetch(
        _ request: any SearchListRequest
    ) async -> Result<any SearchListResponse, SearchListError> {
        let token = authDatasource.userInfo().githubToken
        guard token.count > 0 else {
            return .failure(.githubTokenNotFound)
        }
        
        do {
            let response = try await remoteDatasource.get_search_users(
                header: SearchHeaderDTO(
                    token: token
                ),
                request: SearchRequestDTO(
                    q: request.query,
                    per_page: request.perPage,
                    page: request.page
                )
            )
            
            return .success(self.toDomain(response))
            
        } catch {
            guard let apiError = error as? UserAPICoreError else {
                return .failure(.unKnown)
            }
            return .failure(.restAPI(statusCode: apiError.statusCode))
        }
    }
    
    private func toDomain(_ response: SearchResponseDTO) -> SearchListResponse {
        return SearchListResponseImpl(
            totalCount: response.total_count,
            items: response.items.map {
                return SearchListItemImpl(
                    id: $0.id,
                    login: $0.login,
                    nodeId: $0.nodeId ?? "",
                    avatarUrl: $0.avatar_url
                )
            }
        )
    }
}
