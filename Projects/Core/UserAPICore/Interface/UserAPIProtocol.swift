import Foundation

public protocol UserAPIProtocol {
    func get_search_users(
        header: SearchHeaderDTO,
        request: SearchRequestDTO
    ) async throws -> SearchResponseDTO
}
