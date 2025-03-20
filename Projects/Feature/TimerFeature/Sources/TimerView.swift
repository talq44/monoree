import SwiftUI

import ComposableArchitecture

struct TimerView: View {
    
    let store: StoreOf<TimerReducer>
    
    var body: some View {
        Text(store.currentTime)
            .font(.largeTitle)
            .bold()
            .foregroundStyle(store.textColor)
            .padding()
            .onTapGesture {
                store.send(.start)
            }
    }
}

#Preview {
    TimerView(
        store: Store(
            initialState: TimerReducer.State(),
            reducer: {
                TimerReducer()
            }
        )
    )
}
