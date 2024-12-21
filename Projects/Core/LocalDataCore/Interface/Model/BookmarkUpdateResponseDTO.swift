import Foundation

public protocol BookmarkUpdateResponseDTO: Decodable {
    var id: Int { get }
    var isBookmarked: Bool { get }
}
