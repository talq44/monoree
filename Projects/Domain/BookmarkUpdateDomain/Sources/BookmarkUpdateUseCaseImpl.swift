import Foundation
import Combine

import BookmarkUpdateDomainInterface

final class BookmarkUpdateUseCaseImpl: BookmarkUpdateUseCase {
    
    private let repository: BookmarkUpdateRepository
    
    internal var bookmarkUpdate: AnyPublisher<any BookmarkUpdateOutput, Never>
    private let _bookmarkUpdate = PassthroughSubject<any BookmarkUpdateOutput, Never>()
    
    init(
        repository: BookmarkUpdateRepository
    ) {
        self.bookmarkUpdate = _bookmarkUpdate.eraseToAnyPublisher()
        self.repository = repository
    }
    
    func execute(
        _ input: BookmarkUpdateInput
    ) -> Result<BookmarkUpdateOutput, BookmarkUpdateError> {
        let request = BookmarkUpdateRequestImpl(
            id: input.id,
            isAdd: input.isAdd,
            name: input.name,
            avatarUrl: input.avatarUrl
        )
        let response = self.repository.update(request)
        
        switch response {
        case .success(let success):
            let output = BookmarkUpdateOutputImpl(
                id: success.id,
                isBookMark: success.isBookMark
            )
            self._bookmarkUpdate.send(output)
            return .success(output)
            
        case .failure(let failure):
            return .failure(failure)
        }
    }
}
