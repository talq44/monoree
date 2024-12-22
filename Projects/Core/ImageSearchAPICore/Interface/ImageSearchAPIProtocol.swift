public protocol ImageSearchAPIProtocol {
    func get_search_image(
        header: ImageSearchHeaderDTO,
        request: ImageSearchReqeustDTO
    ) async throws -> ImageSearchResponseDTO
}
