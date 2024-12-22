import Foundation

extension API {
    public var path: String {
        switch self {
        case .get_search_image:
            return "/v1/search/image"
        }
    }
}
