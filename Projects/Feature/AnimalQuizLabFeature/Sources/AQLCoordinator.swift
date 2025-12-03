import UIKit
import GameEntityDomainInterface

public struct AQLCoordinator {
    public static func home(payload: AQLPayload) -> UIViewController {
        AQLConstants.gameUseCase = payload.listUseCase
        AQLConstants.categoryUseCase = payload.categoryListUseCase
        return HomeViewController()
    }
}
