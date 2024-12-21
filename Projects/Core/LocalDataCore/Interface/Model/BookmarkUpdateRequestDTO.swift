import Foundation

public protocol BookmarkUpdateRequestDTO {
    var id: Int { get }
    var isAdd: Bool { get }
    var name: String { get }
    var avatarUrl: String { get }
}
