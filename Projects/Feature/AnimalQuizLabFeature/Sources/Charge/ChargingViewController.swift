import UIKit
import UIKitExtensionShared
import FoundationShared
import SnapKit
import RxSwift
import RxCocoa
import ReactorKit

enum ChargingSection: Int, CaseIterable {
    case payment
    case coin
    case guide
    
    var row: Int {
        switch self {
        case .payment: return ChargingPaymentSection.allCases.count
        case .coin: return ChargingCoinSection.allCases.count
        case .guide: return 1
        }
    }
    
    var title: String {
        switch self {
        case .payment: return "결제"
        case .coin: return "코인"
        case .guide: return "이용 가이드"
        }
    }
}

enum ChargingPaymentSection: Int, CaseIterable {
    case oneDay = 0
    case sevenDay
    case recover
    case history
    
    var title: String {
        switch self {
        case .oneDay: return "1일 이용권"
        case .sevenDay: return "7일 이용권"
        case .recover: return "복구하기"
        case .history: return "결제 내역 보기"
        }
    }
}

enum ChargingCoinSection: Int, CaseIterable {
    case currentState
    case videoCharge
}

final class ChargingViewController: BaseViewController {
    typealias Cell = UITableViewCell
    
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    
    private let coinContentView = VStackView(spacing: Spacing.s)
    private let freeCoinContentStackView = HStackView(spacing: 8)
    private let freeCoinTitleLabel = BaseLabel("🎁 무료 코인")
    private let freeCoinValueLabel = BaseLabel("0")
    private let chargeButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.title = "광고 영상 보고 충전하기 5/5"
        
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
        
        self.view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.directionalEdges.equalToSuperview()
        }
        
        coinContentView.addArrangedSubviews(
            freeCoinContentStackView.addArrangedSubviews(
                freeCoinTitleLabel, freeCoinValueLabel, SpacerView()
            )
        )
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(Cell.self)
        tableView.register(ChargingPaymentItemCell.self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = AnimalQuizLabFeatureStrings.Title.topup
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
        
        switch sectionType {
        case .payment:
            return makePaymentCell(tableView, cellForRowAt: indexPath)
        case .coin:
            return makeCoinCell(tableView, cellForRowAt: indexPath)
        case .guide:
            let cell = tableView.dequeueReusableCell(Cell.self, for: indexPath)
            var config = cell.defaultContentConfiguration()
            config.text = """
        - 무료 코인은 하루에 한번 접속시 증정됩니다.
        - 무료 코인은 하루가 지나면 증정된 무료 코인이 사라집니다.
        - 무료 코인은 프로모션 기간동안 1개 -> 3개의 코인이 증정됩니다.
        
        - 충전 코인은 일정 미션을 진행하면 증정됩니다.
        - 충전 코인은 앱을 삭제하기 전까지 코인이 유지됩니다.
        - 충전 코인은 앱을 삭제하면 복구되지 않습니다.
        - 무료 코인을 우선 소비한 후에, 충전 코인이 소비됩니다.
        """
            cell.contentConfiguration = config
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection sectionIndex: Int) -> String? {
        guard let section = ChargingSection(rawValue: sectionIndex) else { return nil }
        
        return section.title
    }
    
    private func makePaymentCell(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        guard let type = ChargingPaymentSection(rawValue: indexPath.row) else {
            return UITableViewCell()
        }
        
        switch type {
        case .oneDay:
            let cell = tableView.dequeueReusableCell(ChargingPaymentItemCell.self, for: indexPath)
            cell.bind(state: ChargingPaymentItemCell.State(
                title: type.title,
                buttonTitle: "₩1,000",
                action: {
                    print("천원")
                }
            ))
            
            return cell
            
        case .sevenDay:
            let cell = tableView.dequeueReusableCell(ChargingPaymentItemCell.self, for: indexPath)
            cell.bind(state: ChargingPaymentItemCell.State(
                title: type.title,
                buttonTitle: "₩5,000",
                action: {
                    print("5천원")
                }
            ))
            
            return cell
        case .recover:
            let cell = tableView.dequeueReusableCell(ChargingPaymentItemCell.self, for: indexPath)
            cell.bind(state: ChargingPaymentItemCell.State(
                title: type.title,
                buttonTitle: "복구",
                action: {
                    print("복구")
                }
            ))
            
            return cell
        case .history:
            let cell = tableView.dequeueReusableCell(Cell.self, for: indexPath)
            var config = cell.defaultContentConfiguration()
            config.text = type.title
            cell.accessoryView = nil
            cell.accessoryType = .disclosureIndicator
            cell.contentConfiguration = config
            
            return cell
        }
    }
    
    private func makeCoinCell(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        guard let type = ChargingCoinSection(rawValue: indexPath.row) else {
            return UITableViewCell()
        }
        
        let cell = tableView.dequeueReusableCell(Cell.self, for: indexPath)
        
        switch type {
        case .currentState:
            cell.contentView.addSubview(coinContentView)
            coinContentView.snp.remakeConstraints { make in
                make.directionalEdges.equalToSuperview().inset(Spacing.m)
            }
            
        case .videoCharge:
            cell.addSubview(chargeButton)
            chargeButton.snp.remakeConstraints { make in
                make.directionalEdges.equalToSuperview().inset(Spacing.m)
            }
        }
        
        return cell
    }
    
    private func handlePaymentButtonTap(section: ChargingPaymentSection, indexPath: IndexPath) {
        print("Payment button tapped: \(section) at \(indexPath)")
    }
}

extension ChargingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
