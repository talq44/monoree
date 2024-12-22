import Foundation

import ImageSearchAPICoreInterface

import Moya

public enum API {
    case get_search_image(
        request: ImageSearchReqeustDTO
    )
}

extension API: Moya.TargetType {
    public var baseURL: URL {
        return URL(string: "https://openapi.naver.com")!
    }
}
