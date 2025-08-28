import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        // UIWindow 설정
        window = UIWindow(frame: UIScreen.main.bounds)
        
        window?.rootViewController = ViewController()
        
        return true
    }
}
