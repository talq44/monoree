import UIKit

import LocalDataCore
import BookmarkListDomain
import BookmarkUpdateDomain
import BookmarkFeature
import BookmarkFeatureInterface

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
        
        let viewController = container.resolve(BookmarkOutput.self)!
            .viewController
        viewController.title = "Bookmark Feature"
        let navigationController = UINavigationController(rootViewController: viewController)
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
                    BookmarkListAssembly(),
                    BookmarkUpdateAssembly(),
                    LocalDataAssembly(realm: realm),
                    BookmarkAssembly(),
                ],
                container: self.container
            )
        } catch {
            print("error \(error.localizedDescription)")
        }
    }
}
