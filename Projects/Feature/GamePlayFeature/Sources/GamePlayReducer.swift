import ComposableArchitecture
import Foundation
import GamePlayFeatureInterface
import SwiftUI

@Reducer
struct GamePlayReducer {
    // MARK: - State
    @ObservableState
    struct State: Equatable {
        var currentStage: Int = 1
        var totalStages: Int
        var gameTypes: [GamePlayType]
        var isShowingProblem: Bool = false
        var isShowingResult: Bool = false
        var results: [Bool] = []
        var timeInterval: TimeInterval
        var remainingTime: TimeInterval
        var isTimerComplete: Bool = false
        
        init(
            gameTypes: [GamePlayType],
            timeInterval: TimeInterval
        ) {
            self.gameTypes = gameTypes
            self.totalStages = gameTypes.count
            self.timeInterval = timeInterval
            self.remainingTime = timeInterval
        }
        
        var currentProblem: GamePlayType? {
            guard currentStage <= gameTypes.count else { return nil }
            return gameTypes[currentStage - 1]
        }
        
        var isCompleted: Bool {
            currentStage > totalStages
        }
        
        var score: Int {
            results.filter { $0 }.count
        }
        
        var timerOpacity: Double {
            let percentage = remainingTime / timeInterval
            switch percentage {
            case 0.5...1.0: return 0.5
            case 0.25...0.5: return 0.7
            case 0.00..<0.25: return 0.85
            default: return 0.5
            }
        }
    }
    
    // MARK: - Action
    enum Action: Equatable {
        case showStage
        case showProblem
        case answerSelected(Bool)
        case showResult
        case timerTick
    }
    
    // MARK: - Dependencies
    @Dependency(\.continuousClock) var clock
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .showStage:
                state.isShowingProblem = false
                state.isTimerComplete = false
                state.remainingTime = state.timeInterval
                if state.isCompleted {
                    return .send(.showResult)
                }
                return .run { send in
                    try await clock.sleep(for: .seconds(1))
                    await send(.showProblem)
                }
                
            case .showProblem:
                state.isShowingProblem = true
                return .run { send in
                    for await _ in clock.timer(interval: .milliseconds(100)) {
                        await send(.timerTick)
                    }
                }
                
            case .timerTick:
                if state.remainingTime > 0.1 {
                    state.remainingTime -= 0.1
                } else {
                    state.remainingTime = 0
                    state.isTimerComplete = true
                }
                return .none
                
            case .answerSelected(let isCorrect):
                state.results.append(isCorrect)
                state.currentStage += 1
                return .send(.showStage)
                
            case .showResult:
                state.isShowingResult = true
                return .none
            }
        }
    }
}
