import Combine
import ComposableArchitecture
import Foundation
import SwiftUI
import TimerFeatureInterface

// MARK: - TimerFeature.Service (TMA 구조 적용)
final public class TimerServiceImpl: TimerService {
    private let store: StoreOf<TimerReducer>
    private let timerView: TimerView
    private let finishedSubject = PassthroughSubject<Bool, Never>()
    private var cancellables = Set<AnyCancellable>()
    
    public init(initialTime: TimerFeatureInterface.TimeType = .seconds_3) {
        self.store = .init(
            initialState: TimerReducer.State(
                totalTime: initialTime.timeInterval
            ),
            reducer: { TimerReducer() }
        )
        
        self.timerView = TimerView(store: store)
        
        // isComplete 상태 변화 감지
        self.store.publisher.isComplete
            .sink { [weak self] isComplete in
                self?.finishedSubject.send(isComplete)
            }
            .store(in: &cancellables)
    }
    
    public func setTime(_ time: TimerFeatureInterface.TimeType) {
        self.store.send(.setTime(time.timeInterval))
    }
    
    public func start() -> AnyPublisher<Bool, Never> {
        self.store.send(.start)
        return self.finishedSubject.eraseToAnyPublisher()
    }
    
    public func stop() {
        self.store.send(.stop)
    }
    
    public func view() -> AnyView {
        AnyView(self.timerView)
    }
}
