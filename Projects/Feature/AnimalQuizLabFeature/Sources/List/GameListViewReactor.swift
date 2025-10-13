import Foundation
import ReactorKit
import RxSwift

enum GameListViewAction {
    case selectItem(GameListType)
}

struct GameListViewState: Equatable {
    let items: [GameListType] = GameListType.allCases
}

final class GameListViewReactor: Reactor {
    typealias Action = GameListViewAction
    typealias State = GameListViewState
    
    let initialState: GameListViewState
    
    init() {
        initialState = .init()
    }
}
