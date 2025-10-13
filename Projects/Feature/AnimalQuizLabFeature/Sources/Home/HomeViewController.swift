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
    
    override func loadView() {
        super.loadView()
        
        self.view.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.directionalEdges.equalTo(view.safeAreaLayoutGuide)
        }
        
        bannerView.snp.makeConstraints { make in
            make.height.equalTo(Metric.bannerHeight)
        }
        
        bannerView.backgroundColor = .green
        
        stackView.addArrangedSubview(contentView)
        stackView.addArrangedSubview(bannerView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "홈"
        
        setupNavigationBar()
    }
}
