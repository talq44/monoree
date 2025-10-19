import UIKit
import UIKitExtensionShared
import FoundationShared
import SnapKit
import RxSwift
import RxCocoa
import ReactorKit

enum ChargingSection: Int, CaseIterable {
    case payemnt
    case coin
    case guide
    
    var row: Int {
        switch self {
        case .payemnt: return 3
        case .coin: return 2
        case .guide: return 1
        }
    }
    
    var title: String {
        switch self {
        case .payemnt: return "결제"
        case .coin: return "코인"
        case .guide: return "이용 가이드"
        }
    }
}

enum ChargingPaymentSection: Int {
    case oneDay = 0
    case seventDay
    case recover
    case history
    
    var title: String {
        switch self {
        case .oneDay: return "1일 이용권"
        case .seventDay: return "7일 이용권"
        case .recover: return "복구하기"
        case .history: return "결제 내역 보기"
        }
    }
    
    var systemName: String {
        switch self {
        case .oneDay: return "1.calendar"
        case .seventDay: return "7.calendar"
        case .recover: return "arrow.clockwise.circle"
        case .history: return "list.bullet"
        }
    }
}

final class ChargingViewController: BaseViewController {
    typealias Cell = UITableViewCell
    
    private let stackView = VStackView(spacing: Spacing.m)
    
    private let coinContentView = ContentVStackView()
    
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    
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
        
        self.title = "충전소"
        tableView.dataSource = self
        tableView.register(Cell.self, forCellReuseIdentifier: "Cell")
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

extension ChargingViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return ChargingSection.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sectionType = ChargingSection(rawValue: section) else { return 0 }
        return sectionType.row
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let sectionType = ChargingSection(rawValue: indexPath.section) else {
            return UITableViewCell()
        }
        
        let cell = tableView.dequeueReusableCell(Cell.self, for: indexPath)
        
        return cell
    }
}
