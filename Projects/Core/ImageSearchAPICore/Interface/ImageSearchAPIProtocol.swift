public protocol ImageSearchAPIProtocol {
    func get_search_image(
        request: ImageSearchReqeustDTO
    ) async throws -> ImageSearchResponseDTO
}
