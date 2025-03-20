import Foundation
import Combine
import SwiftUI

import TimerFeatureInterface

import ComposableArchitecture

// MARK: - TimerFeature.Service (TMA 구조 적용)
final public class TimerServiceImpl: TimerService {
    private let store: StoreOf<TimerReducer>
    private var finishedSubject = PassthroughSubject<Bool, Never>()
    
    public init(initialTime: TimerFeatureInterface.TimeType = .seconds_3) {
        self.store = .init(
            initialState: TimerReducer.State(
                totalTime: initialTime.timeInterval
            ),
            reducer: { TimerReducer() }
        )
    }
    
    public func setTime(_ time: TimerFeatureInterface.TimeType) {
        store.send(.setTime(time.timeInterval))
    }
    
    public func start() -> AnyPublisher<Bool, Never> {
        store.send(.start)
        return finishedSubject.eraseToAnyPublisher()
    }
    
    public func stop() {
        store.send(.stop)
    }
    
    public func view() -> AnyView {
        AnyView(TimerView(store: store))
    }
}
