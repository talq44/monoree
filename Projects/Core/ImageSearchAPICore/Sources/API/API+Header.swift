import Foundation

extension API {
    public var headers: [String : String]? {
        switch self {
        case .get_search_image:
            return [
                "X-Naver-Client-Id": Constants.Header.clientId,
                "X-Naver-Client-Secret": Constants.Header.clientSecret
            ]
        }
    }
}
