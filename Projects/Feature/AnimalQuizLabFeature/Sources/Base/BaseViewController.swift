import UIKit
import RxSwift

class BaseViewController: UIViewController {
    internal var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGroupedBackground
    }
    
    internal func setupNavigationBarCoin() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: coinButton())
    }
    
    internal func setupNavigationBarHome() {
        self.navigationItem.rightBarButtonItems = [
            UIBarButtonItem(customView: settingButton()),
            UIBarButtonItem(customView: coinButton())
        ]
    }
    
    private func coinButton() -> UIButton {
        let action = UIAction(handler: { [weak self] _ in
            let vc = ChargingViewController()
            self?.navigationController?.pushViewController(vc, animated: true)
        })
        
        var configuration = UIButton.Configuration.plain()
        configuration.image = UIImage(systemName: "c.circle")?.withTintColor(.systemYellow)
        configuration.title = "coin 3"
        
        let button = UIButton(configuration: configuration, primaryAction: action)
        button.isSymbolAnimationEnabled = true
        
        return button
    }
    
    private func settingButton() -> UIButton {
        let action = UIAction(handler: { [weak self] _ in
            self?.navigationController?.pushViewController(SettingViewController(), animated: true)
        })
        
        var configuration = UIButton.Configuration.plain()
        configuration.image = UIImage(systemName: "gearshape")
        
        let button = UIButton(configuration: configuration, primaryAction: action)
        button.isSymbolAnimationEnabled = true
        
        return button
    }
}
