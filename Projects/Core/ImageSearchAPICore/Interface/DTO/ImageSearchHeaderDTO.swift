public struct ImageSearchHeaderDTO: Encodable {
    /// 애플리케이션 등록 시 발급받은 클라이언트 아이디 값
    public let clientId: String
    /// 애플리케이션 등록 시 발급받은 클라이언트 시크릿 값
    public let clientSecret: String
}

