//
//  MainTabViewReactor.swift
//  Remember
//
//  Created by 박창규 on 12/3/24.
//

import Foundation

import ReactorKit
import RxSwift

final class MainTabViewReactor: Reactor {
    typealias Action = MainTabViewAction
    typealias Mutation = MainTabViewMutation
    typealias State = MainTabViewState
    
    var initialState: MainTabViewState = .init(
        currentTab: MainTabType.search,
        title: MainTabType.search.pageTitle
    )
    
    func mutate(action: MainTabViewAction) -> Observable<MainTabViewMutation> {
        switch action {
        case .didSelectTab(let tab):
            guard self.currentState.currentTab != tab else { return .empty() }
            return .just(.setState(tab: tab))
        }
    }
    
    func reduce(state: MainTabViewState, mutation: MainTabViewMutation) -> MainTabViewState {
        var state = state
        switch mutation {
        case .setState(let tab):
            state.currentTab = tab
            state.title = tab.pageTitle
        }
        
        return state
    }
}
