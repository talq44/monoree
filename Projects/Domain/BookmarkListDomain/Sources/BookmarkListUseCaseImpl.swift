import Foundation

import BookmarkListDomainInterface

final class BookmarkListUseCaseImpl: BookmarkListUseCase {
    
    private enum Constants {
        static let usernameRegex = "^[A-Za-zÀ-ÖØ-öø-ÿ\\p{L}\\p{M}'\\-\\s]+$"
    }
    
    private let repository: BookmarkListRepository
    
    init(repository: BookmarkListRepository) {
        self.repository = repository
    }
    
    func execute(
        _ input: any BookmarkListInput
    ) -> Result<any BookmarkListOutput, BookmarkListError> {
        
        let request = BookmarkListRequestImpl()
        
        let response = self.repository.fetch(request)
        
        switch response {
        case .success(let success):
            let items = self.domain(query: input.query, items: success.items)
            return .success(BookmarkListOutputImpl(items: items))
            
        case .failure(let failure):
            return .failure(failure)
        }
    }
    
    /// 목록에 대한 도메인 처리를 함수로 분리합니다.
    private func domain(
        query: String,
        items: [any BookmarkListItem]
    ) -> [any BookmarkListItem] {
        guard query.count > 0 else {
            return items
        }
        
        // 검색어 종류는 사용자 이름으로 제한합니다.
        // 표준적인 정규식 추가
        guard self.checkNameRegex(query: query) else {
            return []
        }
        
        return items
            .filter { $0.login.lowercased().contains(query.lowercased()) }
            .sorted { $0.login < $1.login }
    }
    
    func execute() -> Result<any BookmarkListOutput, BookmarkListError> {
        
        let request = BookmarkListRequestImpl()
        
        let response = self.repository.fetch(request)
        
        switch response {
        case .success(let success):
            return .success(BookmarkListOutputImpl(items: success.items))
            
        case .failure(let failure):
            return .failure(failure)
        }
    }
    
    private func checkNameRegex(query: String) -> Bool {
        // 소문자로 변환 (선택사항)
        let sanitizedQuery = query.lowercased()

        // 정규식 검사
        let predicate = NSPredicate(
            format: "SELF MATCHES %@",
            Constants.usernameRegex
        )
        
        guard predicate.evaluate(with: sanitizedQuery) else {
            return false
        }

        return true
    }
}
