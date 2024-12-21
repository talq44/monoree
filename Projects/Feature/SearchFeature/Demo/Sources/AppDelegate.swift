import UIKit

import UserAPICore
import LocalDataCore
import SearchListDomain
import BookmarkListDomain
import BookmarkUpdateDomain
import SearchFeature
import SearchFeatureInterface
import AuthCore

import Swinject
import Realm
import RealmSwift

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    internal var container = Swinject.Container()
    private var assembler: Assembler?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        self.diContainer()
        
        let searchViewController = container.resolve(SearchFeatureOutput.self)!
            .viewController
        searchViewController.title = "Search Feature"
        
        let navigationController = UINavigationController(
            rootViewController: searchViewController
        )
        window?.backgroundColor = .systemBackground
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()

        return true
    }
    
    private func diContainer() {
        do {
            let realm = try Realm()
            // dependency injection
            self.assembler = Assembler(
                [
                    UserAPICoreAssembly(
                        baseURL: "https://api.github.com"
                    ),
                    AuthCoreAssembly(githubToken: ""),
                    BookmarkListAssembly(),
                    BookmarkUpdateAssembly(),
                    LocalDataAssembly(realm: realm),
                    SearchListAssembly(),
                    SearchViewAssembly(),
                ],
                container: self.container
            )
        } catch {
            print("error \(error.localizedDescription)")
        }
    }
}
