import SwiftUI

import ComposableArchitecture

struct TimerView: View {
    
    let store: StoreOf<TimerReducer>
    
    var body: some View {
        Text(store.currentTime)
            .font(.largeTitle)
            .bold()
            .padding()
    }
}

#Preview {
    TimerView(
        store: Store(
            initialState: TimerReducer.State(totalTime: 3.0),
            reducer: {
                TimerReducer()
            }
        )
    )
}
