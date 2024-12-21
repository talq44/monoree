//
//  BookmarkViewReactor.swift
//  BookmarkFeature
//
//  Created by 박창규 on 12/2/24.
//

import Foundation

import BookmarkListDomainInterface
import BookmarkUpdateDomainInterface
import ReactiveXShared

import RxSwift
import ReactorKit

final class BookmarkViewReactor: Reactor {
    typealias Action = BookmarkViewAction
    typealias Mutation = BookmarkViewMutation
    typealias State = BookmarkViewState
    
    var initialState: BookmarkViewState = .first
    
    private let bookmarkListUseCase: BookmarkListUseCase
    private let bookmarkUpdateUseCase: BookmarkUpdateUseCase
    
    private var query: String = ""
    private var items: [BookmarkViewItem] = []
    
#if DEBUG
    init(initialState: State) {
        self.initialState = initialState
        self.bookmarkListUseCase = FakeBookmarkListUseCase(count: 10)
        self.bookmarkUpdateUseCase = FakeBookmarkUpdateUseCase()
    }
#endif
    
    init(
        bookmarkListUseCase: BookmarkListUseCase,
        bookmarkUpdateUseCase: BookmarkUpdateUseCase
    ) {
        self.bookmarkListUseCase = bookmarkListUseCase
        self.bookmarkUpdateUseCase = bookmarkUpdateUseCase
    }
    
    func transform(action: Observable<Action>) -> Observable<Action> {
        // Apply throttle to limit action emissions
        return action.throttle(.milliseconds(500), scheduler: MainScheduler.instance)
    }
    
    func mutate(
        action: BookmarkViewAction
    ) -> Observable<BookmarkViewMutation> {
        switch action {
        case .viewDidLoad:
            return self.mutation(query: "")
            
        case let .refresh(query):
            return self.mutation(query: query)
            
        case .inputSearch(let query):
            return .concat([
                .just(.setLoading),
                self.mutation(query: query)
            ])
            
        case .didSelectSearch(let query):
            return .concat([
                .just(.setLoading),
                self.mutation(query: query)
            ])
            
        case .selectBookmark(let id):
            guard let item = self.items.filter({ $0.id == id }).first else {
                return .empty()
            }
            
            return self.mutateAddBookmark(item: item)
        }
    }
    
    func transform(
        mutation: Observable<BookmarkViewMutation>
    ) -> Observable<BookmarkViewMutation> {
        let bookmarkUpdate = self.mutation(self.bookmarkUpdateUseCase)
        
        return .merge([
            mutation,
            bookmarkUpdate
        ])
    }
    
    func reduce(
        state: State,
        mutation: Mutation
    ) -> State {
        var state = state
        switch mutation {
        case let .setList(items):
            var nextItems = self.items
            
            nextItems = items
            
            guard nextItems != self.items else { return state }
            
            self.items = nextItems
            
            guard self.items.count > 0 else {
                state = .noResults
                return state
            }
            
            state = .results(items: self.items)
            
        case let .updateList(id, isBookmarked):
            guard let index = self.items.firstIndex(
                where: { $0.id == id }
            ) else {
                return state
            }
            self.items[index].isBookmarked = isBookmarked
            
            guard self.items.count > 0 else {
                state = .noResults
                return state
            }
            
            state = .results(items: self.items)
            
        case .setFirst:
            self.items = []
            state = .first
            
        case .setEmpty:
            self.items = []
            state = .noResults
            
        case .setLoading:
            state = .loading
            
        case .setError(let message):
            state = .error(message: message)
        }
        return state
    }
}

// MARK: - BookmarkListUsecase
extension BookmarkViewReactor {
    private func mutation(
        query: String
    ) -> Observable<BookmarkViewMutation> {
        let input = BookmarkListInputImpl(query: query)
        let bookmarkResponse = self.bookmarkListUseCase.execute(input)
        
        switch bookmarkResponse {
        case .success(let success):
            let items = self.toViewState(success)
            return .just(.setList(items: items))
            
        case .failure(let failure):
            return .just(.setError(message: failure.localizedDescription))
        }
    }
    
    private func toViewState(
        _ bookmarkResponse: BookmarkListOutput
    ) -> [BookmarkViewItem] {
        let items = bookmarkResponse.items.map { item in
            BookmarkViewItem(
                id: item.id,
                name: item.login,
                imageURL: item.avatarUrl,
                isBookmarked: true // 즐겨찾기에서 온 값이라 초기값은 true
            )
        }
        return items
    }
}

// MARK: - BookmarkUpdateUsecase
extension BookmarkViewReactor {
    func mutateAddBookmark(
        item: BookmarkViewItem
    ) -> Observable<Mutation> {
        let input = BookmarkUpdateInputImpl(
            id: item.id,
            isAdd: !item.isBookmarked,
            name: item.name,
            avatarUrl: item.imageURL
        )
        
        let response = self.bookmarkUpdateUseCase.execute(input)
        switch response {
        case .success(let success):
            return .just(.updateList(
                id: success.id,
                isBookmarked: success.isBookMark
            ))
            
        case .failure(let error):
            return .just(.setError(message: error.localizedDescription))
        }
    }
    
    func mutation(
        _ bookmarkUpdateuseCase: BookmarkUpdateUseCase
    ) -> Observable<BookmarkViewMutation> {
        let observable = bookmarkUpdateuseCase.bookmarkUpdate.asObservable()
        
        return observable.map { [weak self] _ in
            // 변경을 감지하면 전체 리스트를 가지고 옴
            return self?.mutation(query: "")
        }
        .compactMap { $0 }
        .flatMap { $0 }
    }
}
