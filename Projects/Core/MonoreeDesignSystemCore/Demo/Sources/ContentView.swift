import SwiftUI
import MonoreeDesignSystemCore

struct ContentView: View {
    var body: some View {
        NavigationStack {
            List {
                Section("Foundation") {
                    NavigationLink("Foundation", destination: Text("Foundation Placeholder"))
                }
                Section("Components") {
                    NavigationLink("Components", destination: ComponentsView())
                }
            }
        }
    }
}

struct ComponentsView: View {
    var body: some View {
        List {
            NavigationLink("Thumbnail", destination: ThumbnailListView())
        }
    }
}

struct ThumbnailListView: View {
    var body: some View {
        ScrollView {
            VStack {
                ForEach(ThumbnailType.allCases) { type in
                    VStack {
                        ThumbnailView(urlString: "https://e0.pxfuel.com/wallpapers/242/813/desktop-wallpaper-apple-logo-for-iphone-apple-symbol.jpg", type: type)
                        Text(type.rawValue)
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
