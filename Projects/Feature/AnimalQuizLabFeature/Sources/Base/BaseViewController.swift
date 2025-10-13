import UIKit
import RxSwift

class BaseViewController: UIViewController {
    internal let disposeBag = DisposeBag()
    
    internal func setupNavigationBar() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: coinButton())
    }
    
    private func coinButton() -> UIButton {
        let action = UIAction(handler: { [weak self] _ in
            let vc = ChargingViewController()
            self?.navigationController?.pushViewController(vc, animated: true)
        })
        
        var configuration = UIButton.Configuration.plain()
        configuration.image = UIImage(systemName: "c.circle")?.withTintColor(.systemYellow)
        configuration.title = "coin 3"

        return UIButton(configuration: configuration, primaryAction: action)
    }
}
