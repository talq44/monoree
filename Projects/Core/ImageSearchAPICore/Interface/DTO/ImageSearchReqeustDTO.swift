public struct ImageSearchReqeustDTO: Encodable {
    public let query: String
    /// 한 번에 표시할 검색 결과 개수(기본값: 10, 최댓값: 100)
    public let display: Int?
    /// 검색 시작 위치(기본값: 1, 최댓값: 1000)
    public let start: Int?
    /// 검색 결과 정렬 방법
    /// - sim: 정확도순으로 내림차순 정렬(기본값)
    /// - date: 날짜순으로 내림차순 정렬
    public let sort: String?
    /// 크기별 검색 결과 필터
    /// - all: 모든 이미지(기본값)
    /// - large: 큰 이미지
    /// - medium: 중간 크기 이미지
    /// - small: 작은 크기 이미지
    public let filter: String?
    
    init(
        query: String,
        display: Int? = nil,
        start: Int? = nil,
        sort: String? = nil,
        filter: String? = nil
    ) {
        self.query = query
        self.display = display
        self.start = start
        self.sort = sort
        self.filter = filter
    }
}
