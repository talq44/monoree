import UIKit
import UIKitExtensionShared
import FoundationShared
import SnapKit
import RxSwift
import RxCocoa
import ReactorKit

final class ChargingViewController: BaseViewController {
    private let stackView = VStackView(spacing: Spacing.m)
    
    private let coinContentView = ContentVStackView()
    
    private let freeCoinContentStackView = HStackView(spacing: 8)
    private let freeCoinTitleLabel = BaseLabel("🎁 무료 코인",style: .title3)
    private let freeCoinValueLabel = BaseLabel("0", style: .title3)
    private let chargeCoinContentStackView = HStackView(spacing: 8)
    private let chargeCoinTitleLabel = BaseLabel("💰 충전 코인",style: .title3)
    private let chargeCoinValueLabel = BaseLabel("0", style: .title3)
    private let coinDescriptionLabel = BaseLabel(
        """
        - 무료 코인은 하루에 한번 접속시 증정됩니다.
        - 무료 코인은 하루가 지나면 증정된 무료 코인이 사라집니다.
        - 무료 코인은 프로모션 기간동안 1개 -> 3개의 코인이 증정됩니다.
        
        - 충전 코인은 일정 미션을 진행하면 증정됩니다.
        - 충전 코인은 앱을 삭제하기 전까지 코인이 유지됩니다.
        - 충전 코인은 앱을 삭제하면 복구되지 않습니다.
        - 무료 코인을 우선 소비한 후에, 충전 코인이 소비됩니다.
        """,
        style: .caption1,
        isMultipleLines: true
    )
    
    private let chargeContentView = ContentVStackView()
    private let chargeTitleLabel = BaseLabel("🎬 충전하기", style: .title3)
    private let chargeButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.title = "광고 영상 보고 충전하기 5/5"
        configuration.baseBackgroundColor = .systemYellow
        
        return UIButton(configuration: configuration)
    }()
    
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
            coinContentView,
            chargeContentView,
            SpacerView()
        )
        
        coinContentView.stackView.addArrangedSubviews(
            freeCoinContentStackView.addArrangedSubviews(
                freeCoinTitleLabel, freeCoinValueLabel, SpacerView()
            ),
            chargeCoinContentStackView.addArrangedSubviews(
                chargeCoinTitleLabel, chargeCoinValueLabel, SpacerView()
            ),
            coinDescriptionLabel
        )
        
        chargeContentView.stackView.addArrangedSubviews(
            chargeTitleLabel,
            chargeButton
        )
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = AnimalQuizLabFeatureStrings.Title.home
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
