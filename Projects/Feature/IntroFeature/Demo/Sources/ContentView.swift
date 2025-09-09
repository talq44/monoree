import SwiftUI
import IntroFeature

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
            IntroView()
        }
    }
}

#Preview {
    ContentView()
}
