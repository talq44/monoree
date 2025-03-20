import Foundation

import ComposableArchitecture

@Reducer
struct TimerReducer {
    enum Action: Equatable {
        case start
        case stop
        case tick
    }
    
    @ObservableState
    struct State: Equatable {
        var totalTime: TimeInterval // 주입된 전체 시간
        var remainingTime: TimeInterval // 남은 시간
        var currentTime: String // UI에 표시할 시간
        
        init(totalTime: TimeInterval) {
            self.totalTime = totalTime
            self.remainingTime = totalTime
            self.currentTime = String(format: "%.2f", totalTime)
        }
    }
    
    private enum TimerID {
        case timer
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .start:
                return .run { send in
                    for await _ in Timer.publish(
                        every: 0.01,
                        on: .main,
                        in: .common
                    ).autoconnect().values {
                        await send(.tick)
                    }
                }.cancellable(id: TimerID.timer)
                
            case .stop:
                return .cancel(id: TimerID.timer)
                
            case .tick:
                if state.remainingTime > 0.01 {
                    state.remainingTime -= 0.01
                    state.currentTime = String(format: "%.2f", state.remainingTime)
                } else {
                    state.remainingTime = 0.00
                    state.currentTime = "0.00"
                    return .cancel(id: TimerID.timer) // 타이머 종료
                }
                return .none
            }
        }
    }
}
