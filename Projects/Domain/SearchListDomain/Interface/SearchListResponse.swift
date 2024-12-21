import Foundation

public protocol SearchListResponse {
    var totalCount: Int { get }
    var items: [SearchListItem] { get }
}
