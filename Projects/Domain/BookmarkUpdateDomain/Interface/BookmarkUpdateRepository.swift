import Foundation

public protocol BookmarkUpdateRepository {
    func update(
        _ request: BookmarkUpdateRequest
    ) -> Result<BookmarkUpdateResponse, BookmarkUpdateError>
}
