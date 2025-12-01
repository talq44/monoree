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
        case .payment: return NSLocalizedString("payment", comment: "")
        case .coin: return NSLocalizedString("coin", comment: "")
        case .guide: return NSLocalizedString("guide", comment: "")
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
        case .oneDay: return NSLocalizedString("one_day_pass", comment: "")
        case .sevenDay: return NSLocalizedString("seven_day_pass", comment: "")
        case .recover: return NSLocalizedString("restore", comment: "")
        case .history: return NSLocalizedString("payment_history", comment: "")
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
    private let freeCoinTitleLabel = BaseLabel(NSLocalizedString("free_coin_title", comment: ""))
    private let freeCoinValueLabel = BaseLabel("0")
    private let chargeButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.title = NSLocalizedString("watch_ad_and_charge", comment: "")
        
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
        \(NSLocalizedString("free_coin_policy_1", comment: ""))
        \(NSLocalizedString("free_coin_policy_2", comment: ""))
        \(NSLocalizedString("free_coin_policy_3", comment: ""))
        
        \(NSLocalizedString("charged_coin_policy_1", comment: ""))
        \(NSLocalizedString("charged_coin_policy_2", comment: ""))
        \(NSLocalizedString("charged_coin_policy_3", comment: ""))
        \(NSLocalizedString("coin_consumption_policy", comment: ""))
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
                buttonTitle: NSLocalizedString("one_thousand_won", comment: ""),
                action: {
                    print("천원")
                }
            ))
            
            return cell
            
        case .sevenDay:
            let cell = tableView.dequeueReusableCell(ChargingPaymentItemCell.self, for: indexPath)
            cell.bind(state: ChargingPaymentItemCell.State(
                title: type.title,
                buttonTitle: NSLocalizedString("five_thousand_won", comment: ""),
                action: {
                    print("5천원")
                }
            ))
            
            return cell
        case .recover:
            let cell = tableView.dequeueReusableCell(ChargingPaymentItemCell.self, for: indexPath)
            cell.bind(state: ChargingPaymentItemCell.State(
                title: type.title,
                buttonTitle: NSLocalizedString("restore_button", comment: ""),
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
