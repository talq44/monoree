import UIKit
import UIKitExtensionShared
import FoundationShared
import SnapKit
import RxSwift
import RxCocoa
import ReactorKit

final class ChargingViewController: BaseViewController {
    private let stackView = VStackView()
    private let freeCoinContentStackView = HStackView()
    private let freeCoinTitleLabel = BaseLabel("무료 코인",style: .title3)
    private let freeCoinValueLabel = BaseLabel("0", style: .title3)
    
    private let chargeCoinContentStackView = HStackView()
    private let chargeCoinTitleLabel = BaseLabel("충전 코인",style: .title3)
    private let chargeCoinValueLabel = BaseLabel("0", style: .title3)
    
    init(reactor: ChargingViewReactor = .init()) {
        super.init(nibName: nil, bundle: nil)
        self.reactor = reactor
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        
        self.view.addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.directionalVerticalEdges.equalTo(view.safeAreaLayoutGuide)
            make.directionalHorizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(Spacing.l)
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

extension ChargingViewController: ReactorKit.View {
    typealias Reactor = ChargingViewReactor
    
    func bind(reactor: ChargingViewReactor) {
        bindState(state: reactor.state.distinctUntilChanged())
    }
    
    func bindState(state: Observable<Reactor.State>) {
        state.map { $0.freeCoin.decimalString }
            .bind(to: freeCoinValueLabel.rx.text)
            .disposed(by: disposeBag)
        
        state.map { $0.chargeCoin.decimalString }
            .bind(to: chargeCoinValueLabel.rx.text)
            .disposed(by: disposeBag)
    }
}
