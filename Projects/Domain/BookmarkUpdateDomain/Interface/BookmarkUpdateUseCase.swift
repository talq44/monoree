import Foundation
import Combine

public protocol BookmarkUpdateUseCase {
    var bookmarkUpdate: AnyPublisher<BookmarkUpdateOutput, Never> { get }
    
    func execute(
        _ input: BookmarkUpdateInput
    ) -> Result<BookmarkUpdateOutput, BookmarkUpdateError>
}
