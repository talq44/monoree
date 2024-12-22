import Foundation

import Moya

extension API {
    public var method: Moya.Method {
        switch self {
        case .get_search_image:
            return .get
        }
    }
}
