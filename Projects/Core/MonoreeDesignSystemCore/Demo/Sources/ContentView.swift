import SwiftUI
import MonoreeDesignSystemCore

struct ContentView: View {
    var body: some View {
        Text("Hello, World!")
        ScrollView {
            VStack {
                ForEach(ThumbnailType.allCases) { type in
                    ThumbnailView(urlString: "https://e0.pxfuel.com/wallpapers/242/813/desktop-wallpaper-apple-logo-for-iphone-apple-symbol.jpg", type: type)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
