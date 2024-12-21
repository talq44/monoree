import Foundation

public protocol SearchListInput {
    var query: String { get }
    var isMore: Bool { get }
}
