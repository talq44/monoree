import UIKit

import UserAPICore
import LocalDataCore
import BookmarkListDomain
import BookmarkUpdateDomain
import BookmarkFeature
import BookmarkFeatureInterface
import SearchListDomain
import SearchFeature
import SearchFeatureInterface
import AuthCore

import Swinject

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    internal var container = Swinject.Container()
    private var assembler: Assembler?
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        // UIWindow 설정
        window = UIWindow(frame: UIScreen.main.bounds)
        diContainer()
        
        MainTabContainer.start(
            window: self.window,
            container: self.container
        )
        
        return true
    }
    
    private func diContainer() {
        do {
            // dependency injection
            self.assembler = Assembler(
                [
                    UserAPICoreAssembly(
                        baseURL: "https://api.github.com"
                    ),
                    AuthCoreAssembly(githubToken: ""),
                    BookmarkListAssembly(),
                    BookmarkUpdateAssembly(),
                    SearchListAssembly(),
                    SearchViewAssembly(),
                    BookmarkAssembly()
                ],
                container: self.container
            )
        } catch {
            print("error \(error.localizedDescription)")
        }
    }
}
