import SwiftUI

import ComposableArchitecture

import TimerFeatureInterface

public class TimerContainer {
    private let store: StoreOf<TimerReducer> = .init(
        initialState: TimerReducer.State(),
        reducer: { TimerReducer() }
    )
    
    public init() {
        
    }
    
    public func build() -> TimerOutput {
        let view = TimerView(store: store)
        
        return TimerOutput(view: AnyView(view))
    }
}
