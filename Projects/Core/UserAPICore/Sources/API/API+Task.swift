import Foundation
import FoundationShared
import UserAPICoreInterface
import Moya

extension API {
    public var task: Task {
        switch self {
        case let .get_search_users(_, request):
            return .requestParameters(
                parameters: request.parameters(),
                encoding: URLEncoding.queryString
            )
        }
    }
}
