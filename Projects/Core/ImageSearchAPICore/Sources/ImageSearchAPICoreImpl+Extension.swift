import Foundation

import ImageSearchAPICoreInterface

extension ImageSearchAPICoreImpl: ImageSearchAPIProtocol {
    public func get_search_image(
        request: ImageSearchReqeustDTO
    ) async throws -> ImageSearchResponseDTO {
        return try await self.requestJson(
            .get_search_image(request: request),
            type: ImageSearchResponseDTO.self
        )
    }
}
