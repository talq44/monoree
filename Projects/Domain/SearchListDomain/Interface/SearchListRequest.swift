import Foundation

public protocol SearchListRequest {
    var query: String { get }
    var page: Int { get }
    var perPage: Int { get }
    var token: String { get }
}
