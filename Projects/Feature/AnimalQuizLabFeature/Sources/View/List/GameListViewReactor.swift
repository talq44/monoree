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
    case selectItem(GameType, GameType.QuizItem)
}

struct GameListViewState {
    let title: String
    let items: [GameType] = GameType.allCases
    let category: String?
    let itemCategory2: String?
    @Pulse var gamePlayViewPayload: GamePlayViewPayload?
}

final class GameListViewReactor: Reactor {
    typealias Action = GameListViewAction
    typealias State = GameListViewState
    
    let initialState: GameListViewState
    
    private let coinUseCase: CoinUseCase = CoinUseCase(suiteName: "Coin")
    
    init(payload: GameListViewPayload) {
        initialState = GameListViewState(
            title: payload.title,
            category: payload.itemCategory,
            itemCategory2: payload.itemCategory2
        )
    }
}

extension GameListViewReactor {
    func reduce(state: GameListViewState, mutation: GameListViewAction) -> GameListViewState {
        var state = state
        
        switch mutation {
        case .selectItem(let type, let item):
            Task { @MainActor in
                _ = try await coinUseCase.play()
            }
            
            state.gamePlayViewPayload = GamePlayViewPayload(
                type: type,
                category: state.category,
                itemCategory2: state.itemCategory2,
                questionCount: 10,
                choiceCount: item.count,
                isAutoScroll: type == .autoScroll
            )
        }
        
        return state
    }
}

extension GameListViewReactor {
    convenience init() {
        let payload = GameListViewPayload(
            id: "1",
            title: AnimalQuizLabFeatureStrings.title,
            itemCategory: nil,
            itemCategory2: nil
        )
        self.init(payload: payload)
    }
}
