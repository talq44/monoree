import SwiftUI
import GoogleMobileAds

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        let versionNumber = string(for: MobileAds.shared.versionNumber)
        print("Google Mobile Ads SDK version: \(versionNumber)")
        
        MobileAds.shared.start()
        
        return true
    }
}
