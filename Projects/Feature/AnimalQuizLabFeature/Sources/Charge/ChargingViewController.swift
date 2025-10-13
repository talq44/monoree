import UIKit
import UIKitExtensionShared

final class ChargingViewController: BaseViewController {
    private let stackView = VStackView()
    private let freeCoinContentStackView = HStackView()
    private let freeCoinTitleLabel = BaseLabel("무료 코인",style: .title3)
    private let freeCoinValueLabel = BaseLabel("0", style: .title3)
    
    private let chargeCoinContentStackView = HStackView()
    private let chargeCoinTitleLabel = BaseLabel("충전 코인",style: .title3)
    private let chargeCoinValueLabel = BaseLabel("0", style: .title3)
    
    override func loadView() {
        super.loadView()
        
        self.view.addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.directionalHorizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(Spacing.l)
            make.directionalEdges.equalTo(view.safeAreaLayoutGuide)
        }
        
        stackView.addArrangedSubviews(
            freeCoinContentStackView.addArrangedSubviews(
                freeCoinTitleLabel, SpacerView(), freeCoinValueLabel
            ),
            chargeCoinContentStackView.addArrangedSubviews(
                chargeCoinTitleLabel, SpacerView(), chargeCoinValueLabel
            ),
            SpacerView()
        )
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "충전소"
    }
}
