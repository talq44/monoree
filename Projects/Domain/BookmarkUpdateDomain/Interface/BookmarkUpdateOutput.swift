import Foundation

public protocol BookmarkUpdateOutput {
    /// update되어야 하는 Id
    var id: Int { get }
    var isBookMark: Bool { get }
}
