import Foundation
import ReactorKit
import RxSwift

struct GameListViewPayload {
    let id: String
    let title: String
    let itemCategory: String?
    let itemCategory2: String?
}

enum GameListViewAction {
    case selectItem(GameListType)
}

struct GameListViewState {
    let title: String
    let items: [GameListType] = GameListType.allCases
    @Pulse var gamePlayViewPayload: GamePlayViewPayload?
}

final class GameListViewReactor: Reactor {
    typealias Action = GameListViewAction
    typealias State = GameListViewState
    
    let initialState: GameListViewState
    
    init(payload: GameListViewPayload) {
        initialState = .init(title: payload.title)
    }
}

extension GameListViewReactor {
    func reduce(state: GameListViewState, mutation: GameListViewAction) -> GameListViewState {
        var state = state
        
        switch mutation {
        case .selectItem(let gameListType):
            state.gamePlayViewPayload = .init(answerCount: gameListType.count)
        }
        
        return state
    }
}

extension GameListViewReactor {
    convenience init() {
        let payload = GameListViewPayload(
            id: "1",
            title: "타이틀",
            itemCategory: nil,
            itemCategory2: nil
        )
        self.init(payload: payload)
    }
}
