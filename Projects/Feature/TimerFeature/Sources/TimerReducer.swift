import ComposableArchitecture
import Foundation
import SwiftUI
import TimerFeatureInterface

@Reducer
struct TimerReducer {
    enum Action: Equatable {
        case setTime(TimeInterval)
        case start
        case stop
        case tick
    }
    
    @ObservableState
    struct State: Equatable {
        var totalTime: TimeInterval  // 주입된 전체 시간
        var remainingTime: TimeInterval  // 남은 시간
        var currentTime: String  // UI에 표시할 시간
        var isComplete: Bool  // 타이머 완료 상태
        
        init(totalTime: TimeInterval = 3.0) {
            self.totalTime = totalTime
            self.remainingTime = totalTime
            self.currentTime = String(format: "%.1f", totalTime)
            self.isComplete = false
        }
        
        var textColor: Color {
            let percentage = remainingTime / totalTime
            switch percentage {
            case 0.5...1.0: return .black
            case 0.25...0.5: return .orange
            case 0.00..<0.25: return .red
            default: return .black
            }
        }
    }
    
    private enum TimerID {
        case timer
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .setTime(let time):
                state.totalTime = time
                state.remainingTime = time
                state.currentTime = String(format: "%.1f", time)
                state.isComplete = false
                return .none
                
            case .start:
                state.remainingTime = state.totalTime
                state.currentTime = String(format: "%.1f", state.totalTime)
                state.isComplete = false
                
                return .run { send in
                    for await _ in Timer.publish(
                        every: 0.1,
                        on: .main,
                        in: .common
                    ).autoconnect().values {
                        await send(.tick)
                    }
                }.cancellable(id: TimerID.timer)
                
            case .stop:
                state.isComplete = false
                return .cancel(id: TimerID.timer)
                
            case .tick:
                if state.remainingTime > 0.1 {
                    state.remainingTime -= 0.1
                    state.currentTime = String(format: "%.1f", state.remainingTime)
                } else {
                    state.remainingTime = 0.0
                    state.currentTime = "0.0"
                    state.isComplete = true
                    return .cancel(id: TimerID.timer)
                }
                return .none
            }
        }
    }
}
