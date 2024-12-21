//
//  SearchViewReactor.swift
//  SearchFeature
//
//  Created by 박창규 on 11/30/24.
//

import Foundation

import SearchListDomainInterface
import BookmarkUpdateDomainInterface
import BookmarkListDomainInterface
import ReactiveXShared

import ReactorKit
import RxSwift

final class SearchViewReactor: Reactor {
    typealias Action = SearchViewAction
    typealias Mutation = SearchViewMutation
    typealias State = SearchViewState
    
    var initialState: SearchViewState = .first
    
    private var query: String = ""
    private var items: [SearchViewItem] = []
    private var bookMarkIds: Set<Int> = []
    
    // MARK: - UseCases
    private let searchListUseCase: SearchListUseCase
    private let bookmarkUpdateUseCase: BookmarkUpdateUseCase
    private let bookmarkListUseCase: BookmarkListUseCase
    
#if DEBUG
    init(initialState: SearchViewState) {
        self.initialState = initialState
        
        self.searchListUseCase = FakeSearchListUseCase(
            count: initialState.testCount
        )
        self.bookmarkUpdateUseCase = FakeBookmarkUpdateUseCase()
        self.bookmarkListUseCase = FakeBookmarkListUseCase(
            count: initialState.testCount
        )
    }
#endif
    
    init(
        searchListUseCase: SearchListUseCase,
        bookmakrListUseCase: BookmarkListUseCase,
        bookmarkUpdateUseCase: BookmarkUpdateUseCase
    ) {
        self.searchListUseCase = searchListUseCase
        self.bookmarkListUseCase = bookmakrListUseCase
        self.bookmarkUpdateUseCase = bookmarkUpdateUseCase
    }
    
    func transform(action: Observable<Action>) -> Observable<Action> {
        // Apply throttle to limit action emissions
        return action.throttle(.milliseconds(500), scheduler: MainScheduler.instance)
    }
    
    func mutate(action: SearchViewAction) -> Observable<SearchViewMutation> {
        switch action {
        case let .refresh(query):
            guard query.count > 0 else {
                return .just(.setFirst)
            }
            
            return .concat([
                .just(.setLoading),
                self.mutateSearch(query: query, isMore: false)
            ])
            
        case let .inputSearch(query):
            guard query.count > 0 else {
                return .just(.setFirst)
            }
            
            return .concat([
                .just(.setLoading),
                self.mutateSearch(query: query, isMore: false)
            ])
        
        case let .didSelectSearch(query):
            guard query.count > 0 else {
                return .just(.setFirst)
            }
            
            return .concat([
                self.mutateSearch(query: query, isMore: false)
            ])
            
        case let .selectBookMark(id):
            guard let item = self.items.filter({ $0.id == id }).first else {
                return .empty()
            }
            
            return self.mutateAddBookmark(item: item)
            
        case let .willDisplayLast(query):
            guard query == self.query else { return .empty() }
            
            return .concat([
                .just(.setLoading),
                self.mutateSearch(query: query, isMore: true)
            ])
        }
    }
    
    func transform(
        mutation: Observable<SearchViewMutation>
    ) -> Observable<SearchViewMutation> {
        let bookmarkUpdate = self.mutation(self.bookmarkUpdateUseCase)
        return .merge([
            mutation,
            bookmarkUpdate
        ])
    }
    
    func reduce(
        state: SearchViewState,
        mutation: SearchViewMutation
    ) -> SearchViewState {
        var state = state
        switch mutation {
        case let .setSearchList(items, isMore):
            var nextItems = self.items
            if isMore {
                nextItems += items
            } else {
                nextItems = items
            }
            
            guard nextItems != self.items else { return state }
            
            self.items = nextItems
            
            state = .results(items: self.items)
            
        case let .updateSearchList(id, isBookmarked):
            guard let index = self.items.firstIndex(
                where: { $0.id == id }
            ) else {
                return state
            }
            self.items[index].isBookmarked = isBookmarked
            state = .results(items: self.items)
            
        case .setFirst:
            self.items = []
            state = .first
            
        case .setEmpty:
            self.items = []
            state = .noResults
            
        case .setLoading:
            state = .searching
            
        case .setError(let message):
            state = .error(message: message)
        }
        return state
    }
}

// MARK: - Search
extension SearchViewReactor {
    
    func mutateSearch(
        query: String,
        isMore: Bool
    ) -> Observable<SearchViewMutation> {
        let input = SearchListInputImpl(
            query: query,
            isMore: isMore
        )
        
        self.bookMarkIds = self.getBookmarkIds()
        
        return Observable.create { [weak self] emitter in
            guard let self else {
                emitter.onCompleted()
                return Disposables.create()
            }
            
            Task {
                let response = await self.searchListUseCase.execute(input)
                
                switch response {
                case .success(let success):
                    let items = self.toViewState(response: success)
                    
                    guard items.count > 0 else {
                        guard isMore else {
                            emitter.onNext(.setEmpty)
                            emitter.onCompleted()
                            return
                        }
                        emitter.onNext(.setSearchList(items: items, isMore: isMore))
                        emitter.onCompleted()
                        return
                    }
                    self.query = query
                    
                    emitter.onNext(.setSearchList(items: items, isMore: isMore))
                    emitter.onCompleted()
                    
                case .failure(let error):
                    // 에러처리는 추후 추가
                    emitter.onNext(
                        .setError(message: error.localizedDescription)
                    )
                    emitter.onCompleted()
                }
            }
            return Disposables.create()
        }
    }
}

// MARK: - Bookmark
extension SearchViewReactor {
    
    func mutateAddBookmark(
        item: SearchViewItem
    ) -> Observable<SearchViewMutation> {
        let input = BookmarkUpdateInputImpl(
            id: item.id,
            isAdd: !item.isBookmarked,
            name: item.name,
            avatarUrl: item.imageURL
        )
        
        let response = self.bookmarkUpdateUseCase.execute(input)
        switch response {
        case .success(let success):
            return .just(.updateSearchList(
                id: success.id,
                isBookmarked: success.isBookMark
            ))
            
        case .failure(let error): // <-- 에러처리 필요
            return .just(.setError(message: error.localizedDescription))
        }
    }
    
    func getBookmarkIds() -> Set<Int> {
        let bookmarkResponse = self.bookmarkListUseCase.execute()
        
        let boormarkIds: [Int]
        
        switch bookmarkResponse {
        case .success(let success):
            boormarkIds = success.items.map { $0.id }
        case .failure: // <-- 실패하더라도, 화면 노출하기위해 별도 처리하지 않음
            boormarkIds = []
        }
        
        return Set(boormarkIds)
    }
    
    func mutation(
        _ bookmarkUpdateuseCase: BookmarkUpdateUseCase
    ) -> Observable<SearchViewMutation> {
        let observable = bookmarkUpdateuseCase.bookmarkUpdate.asObservable()
        return observable
            .map { .updateSearchList(id: $0.id, isBookmarked: $0.isBookMark )}
    }
}

// MARK: - convert
extension SearchViewReactor {
    private func toViewState(
        response: SearchListOutput
    ) -> [SearchViewItem] {
        return response.items.map {
            return SearchViewItem(
                id: $0.id,
                name: $0.login,
                imageURL: $0.avatarUrl,
                isBookmarked: self.bookMarkIds.contains($0.id)
            )
        }
    }
}
