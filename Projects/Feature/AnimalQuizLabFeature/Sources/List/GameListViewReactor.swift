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

struct GameListViewState: Equatable {
    let title: String
    let items: [GameListType] = GameListType.allCases
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
