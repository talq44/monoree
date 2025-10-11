import SwiftUI

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
            Text("Hello, SwiftUI Demo!")
                .padding()
                .navigationTitle("Demo")
        }
    }
}

#Preview {
    ContentView()
}
