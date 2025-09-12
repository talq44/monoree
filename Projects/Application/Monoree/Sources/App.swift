import SwiftUI

@main
struct MonoreeApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delgate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
