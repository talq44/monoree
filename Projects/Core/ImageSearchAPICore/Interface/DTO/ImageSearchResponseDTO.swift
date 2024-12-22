public struct ImageSearchResponseDTO: Decodable {
    public let lastBuildDate: String
    public let total: Int
    public let start: Int
    public let display: Int
    public let items: [ImageSearchItemDTO]
}
