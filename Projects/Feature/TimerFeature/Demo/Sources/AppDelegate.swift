import SwiftUI

import ComposableArchitecture

import TimerFeature

@main
struct DemoView: App {
    
    var body: some Scene {
        WindowGroup {
            TimerContainer().build().view
//            ZStack {
//                Text("Hi")
//            }
        }
    }
}
//final class AppDelegate: UIResponder, UIApplicationDelegate {
//    var window: UIWindow?
//
//    func application(
//        _ application: UIApplication,
//        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
//    ) -> Bool {
//        window = UIWindow(frame: UIScreen.main.bounds)
//        let viewController = UIViewController()
//        let navigationController = UINavigationController(rootViewController: viewController)
//        window?.rootViewController = navigationController
//        window?.makeKeyAndVisible()
//
//        return true
//    }
//}
