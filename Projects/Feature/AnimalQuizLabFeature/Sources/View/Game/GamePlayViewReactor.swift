import Foundation
import ReactorKit
import RxSwift

struct GamePlayViewPayload {
    let type: GameType
    let category: String?
    let itemCategory2: String?
    let questionCount: Int
    let choiceCount: Int
    let isAutoScroll: Bool
}

enum GamePlayViewAction {
    case refresh
    case selectChoice(question: ProductItem, choice: ProductItem)
}

enum GamePlayViewMutation {
    case setGameItems([GameItem])
    case checkChoice(question: ProductItem, choice: ProductItem)
}

struct GamePlayViewState {
    let gameType: GameType
    let totalPage: Int
    let choiceCount: Int
    var items: [GameItem] = []
    var currentPage: Int = 0
    
    @Pulse var score: [Int: Bool] = [:]
}

final class GamePlayViewReactor: Reactor {
    typealias Action = GamePlayViewAction
    typealias Mutation = GamePlayViewMutation
    typealias State = GamePlayViewState
    
    let initialState: GamePlayViewState
    private let listUseCase: ProductListUseCase
    
    init(
        payload: GamePlayViewPayload,
        listUseCase: ProductListUseCase = ProductListUseCase()
    ) {
        self.listUseCase = listUseCase
        
        initialState = GamePlayViewState(
            gameType: payload.type,
            totalPage: payload.questionCount,
            choiceCount: payload.choiceCount
        )
    }
}

// MARK: - Action
extension GamePlayViewReactor {
    func mutate(action: GamePlayViewAction) -> Observable<GamePlayViewMutation> {
        switch action {
        case .refresh:
            return requestGameList(state: currentState, useCase: listUseCase)
        case let .selectChoice(question, choice):
            return .just(.checkChoice(question: question, choice: choice))
        }
    }
}

// MARK: - Side Effect
extension GamePlayViewReactor {
    private func requestGameList(
        state: GamePlayViewState,
        useCase: ProductListUseCase
    ) -> Observable<GamePlayViewMutation> {
        return Observable.create { emitter in
            let task = Task { @MainActor in
                do {
                    let result = try await useCase.executePlay(
                        withType: state.gameType,
                        questionCount: state.totalPage,
                        choicesCount: state.choiceCount
                    )
                    
                    emitter.onNext(.setGameItems(result))
                } catch {
                    print("error \(error)")
                }
                
                emitter.onCompleted()
            }
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
}

// MARK: - Reduce
extension GamePlayViewReactor {
    func reduce(state: GamePlayViewState, mutation: GamePlayViewMutation) -> GamePlayViewState {
        var state = state
        
        switch mutation {
        case .setGameItems(let array):
            state.items = array
        case let .checkChoice(_, _):
            let nextPage = state.currentPage + 1
            guard nextPage < state.items.count else {
                return state
            }
            
            state.currentPage = nextPage
        }
        return state
    }
}
