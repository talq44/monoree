import Foundation
import ReactorKit
import RxSwift

enum GamePlayViewAction {
    case refresh
    case answer(String)
    case movePageAtIndex(Int)
}

enum GamePlayViewMutation {
    case setInfos(items: [String])
}

struct GamePlayViewState {
    struct Item {
        let id: String
        let name: String
        let imageURL: String?
        let answer: String
        let questions: [String]
    }
    
    let gameType: GameType
    var items: [String] = []
    var currentPage: Int = 0
    let totalPage: Int
    
    @Pulse var score: [Int: Bool] = [:]
}

final class GamePlayViewReactor: Reactor {
    typealias Action = GamePlayViewAction
    typealias Mutation = GamePlayViewMutation
    typealias State = GamePlayViewState
    
    let initialState: GamePlayViewState
    
    init(gameType: GameType, total: Int) {
        initialState = GamePlayViewState(
            gameType: gameType,
            totalPage: total
        )
    }
}
