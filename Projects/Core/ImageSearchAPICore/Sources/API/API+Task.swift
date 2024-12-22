import Foundation

import ImageSearchAPICoreInterface

import Moya

extension API {
    public var task: Task {
        switch self {
        case let .get_search_image(request):
            return .requestParameters(
                parameters: request.parameters(),
                encoding: URLEncoding.queryString
            )
        }
    }
}
