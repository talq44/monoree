import SwiftUI

import IntroFeature
@testable import IntroFeatureTesting

@main
struct DemoApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

struct ContentView: View {
    var body: some View {
        NavigationStack {
            IntroBuilder.build(usecase: MockVersionCheckUsecase(result: .none))
        }
    }
}

#Preview {
    ContentView()
}
