import SwiftUI

import ComposableArchitecture

import TimerFeatureInterface
import TimerFeature

@main
struct DemoView: App {
    private let service: TimerService = TimerServiceImpl(initialTime: .seconds_5)
    
    var body: some Scene {
        WindowGroup {
            service.view()
            Button(
                "타이머 시작",
                action: {
                    _ = service.start()
                }
            )
        }
    }
}
