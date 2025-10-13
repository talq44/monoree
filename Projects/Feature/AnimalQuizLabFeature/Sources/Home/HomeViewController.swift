import UIKit
import SnapKit
import UIKitExtensionShared

final class HomeViewController: BaseViewController {
    private enum Metric {
        static let bannerHeight: CGFloat = 100
    }
    
    private let stackView = VStackView()
    private let contentView = UIView()
    private let bannerView = UIView()
    
    private let testButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.title = "테스트 목록 이동"
        
        return UIButton(configuration: config)
    }()
    
    override func loadView() {
        super.loadView()
        
        self.view.addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.directionalEdges.equalTo(view.safeAreaLayoutGuide)
        }
        
        bannerView.snp.makeConstraints { make in
            make.height.equalTo(Metric.bannerHeight)
        }
        
        stackView.addArrangedSubviews(
            contentView,
            bannerView
        )
        
        bannerView.backgroundColor = .green
        
        contentView.addSubview(testButton)
        
        testButton.snp.makeConstraints { make in
            make.directionalHorizontalEdges.top.equalToSuperview()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "홈"
        
        setupNavigationBar()
        
        testButton.addAction(
            UIAction(handler: { [weak self] _ in
                let vc = GameListViewController()
                self?.navigationController?.pushViewController(vc, animated: true)
            }),
            for: .touchUpInside
        )
    }
}
