import SwiftUI
import IntroFeature
import VersionCheckDomainInterface

@main
struct DemoApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

struct MockVersionCheckUsecase: VersionCheckUsecase {
    func checkVersion(_ currentVersion: String) async -> VersionUpdateResult {
        return .optional(url: "https://www.apple.com")
    }
}

struct ContentView: View {
    var body: some View {
        NavigationStack {
            IntroBuilder.build(usecase: MockVersionCheckUsecase())
        }
    }
}

#Preview {
    ContentView()
}
