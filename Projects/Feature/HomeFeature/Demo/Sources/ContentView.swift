import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            Text("Hello, Monoree")
                .padding()
                .navigationTitle("Home")
        }
    }
}

#Preview {
    ContentView()
}
