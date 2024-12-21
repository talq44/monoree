import Foundation

public protocol SearchListRepository {
    func fetch(
        _ request: SearchListRequest
    ) async -> Result<SearchListResponse, SearchListError>
}
