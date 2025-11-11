import UIKit
import RxSwift
import RxCocoa

class BaseViewController: UIViewController {
    internal var disposeBag = DisposeBag()
    private lazy var baseReactor = BaseViewReactor.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGroupedBackground
    }
    
    internal func setupNavigationBarCoin() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: coinButton())
        baseReactor.action.onNext(.refresh)
        binding()
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

extension BaseViewController {
    func binding() {
        baseReactor.state.map { $0.coinText }
            .distinctUntilChanged()
            .observe(on: MainScheduler.instance)
            .withUnretained(self)
            .subscribe(onNext: { vc, text in
                (vc.navigationItem.rightBarButtonItem?.customView as? UIButton)?.configuration?.title = text
//                vc.navigationItem.rightBarButtonItem?.title = text
            })
            .disposed(by: disposeBag)
    }
}
