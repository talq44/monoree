import Foundation

import SearchListDomainInterface

final class SearchListUseCaseImpl: SearchListUseCase {
    private enum Constants {
        static let perPage: Int = 30
        static let usernameRegex = "^[A-Za-zÀ-ÖØ-öø-ÿ\\p{L}\\p{M}'\\-\\s]+$"
    }
    
    private var page: Int = 0
    private var totalCount: Int = 1
    
    private let repository: SearchListRepository
    
    init(repository: SearchListRepository) {
        self.repository = repository
    }
    
    func execute(
        _ input: any SearchListDomainInterface.SearchListInput
    ) async -> Result<any SearchListOutput, SearchListError> {
        guard self.checkQuery(query: input.query) else {
            return .success(SearchListOutputImpl(items: []))
        }
        
        var page = self.page
        
        switch input.isMore {
        case false:
            page = 1
        case true:
            guard page > 0 else {
                return .failure(.fetchRequiredBeforeMore)
            }
            page += 1
        }
        
        guard self.totalCount > (page - 1) * Constants.perPage else {
            return .success(SearchListOutputImpl(items: []))
        }
        
        let request = SearchListRequestImpl(
            query: input.query,
            page: page,
            perPage: Constants.perPage,
            token: ""
        )
        
        let response = await self.repository.fetch(request)
        
        switch response {
        case .success(let result):
            let totalCount = result.totalCount == 0 ? 1 : result.totalCount
            page = result.totalCount == 0 ? 0 : page
            self.page = page
            self.totalCount = totalCount
            return .success(SearchListOutputImpl(items: result.items))
            
        case .failure(let failure):
            return .failure(failure)
        }
    }
    
    private func checkQuery(query: String) -> Bool {
        // 검색어 종류는 사용자 이름으로 제한합니다.
        // 1. 빈값이면 바로 빈값 반환
        guard query.count > 0 else {
            return false
        }
        
        // 표준적인 정규식 추가
        guard self.checkNameRegex(query: query) else {
            return false
        }
        
        return true
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
