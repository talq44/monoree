import UIKit
import AnimalQuizLabFeature
import GameEntityDomainInterface
import AnimalListDomain

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let payload = AQLPayload(
            bundle: AnimalListDomainResources.bundle,
            listUseCase: AnimalListUseCaseImpl(),
            categoryListUseCase: AnimalCategoryListUseCaseImpl()
        )
        let vc = AQLCoordinator.home(payload: payload)
        let nc = UINavigationController(rootViewController: vc)
        
        nc.navigationBar.prefersLargeTitles = true
        vc.navigationItem.largeTitleDisplayMode = .automatic // 또는 .always
        
        window?.rootViewController = nc
        window?.backgroundColor = .systemBackground
        window?.makeKeyAndVisible()
        
        return true
    }
}
