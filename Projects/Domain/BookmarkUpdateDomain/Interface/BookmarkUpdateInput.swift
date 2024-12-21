import Foundation

public protocol BookmarkUpdateInput {
    /// 업데이트할 user의 ID
    var id: Int { get }
    /// true: 담기, false: 빼기
    var isAdd: Bool { get }
    var name: String { get }
    var avatarUrl: String { get }
}
