import UIKit
import UIKitExtensionShared
import SnapKit
import ReactorKit
import RxSwift
import RxCocoa

final class GameListViewController: BaseViewController {
    private typealias Cell = GameCategoryCell
    
    private enum Metric {
        static let itemHeight: CGFloat = 72
        static let itemSpacing: CGFloat = Spacing.m
    }
    
    private let tableView = UITableView(frame: .zero, style: .grouped)
    private let backgroundImageView = UIImageView()
    
    init(reactor: GameListViewReactor = GameListViewReactor()) {
        super.init(nibName: nil, bundle: nil)
        
        self.reactor = reactor
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        
        view.addSubview(backgroundImageView)
        view.addSubview(tableView)
        
        backgroundImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(Spacing.l)
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(Spacing.l)
        }
        
        tableView.snp.makeConstraints { make in
            make.directionalEdges.equalTo(view.safeAreaLayoutGuide)
        }
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.register(Cell.self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBarCoin()
    }
}

extension GameListViewController: ReactorKit.View {
    typealias Reactor = GameListViewReactor
    
    func bind(reactor: GameListViewReactor) {
        bindAction(reactor: reactor)
        bindState(reactor: reactor)
    }
    
    private func bindAction(reactor: GameListViewReactor) {
        tableView.rx.modelSelected(GameType.self)
            .map { Reactor.Action.selectItem($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    
    private func bindState(reactor: GameListViewReactor) {
        reactor.state.map { $0.items }
            .distinctUntilChanged()
            .bind(to: tableView.rx.items(
                cellIdentifier: String(describing: Cell.self),
                cellType: Cell.self
            )) { _, item, cell in
                cell.bind(type: item)
            }
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.title }
            .distinctUntilChanged()
            .bind(to: self.rx.title)
            .disposed(by: disposeBag)
        
        reactor.pulse(\.$gamePlayViewPayload)
            .compactMap { $0 }
            .subscribe(onNext: { [weak self] payload in
                let vc = GamePlayViewController(payload: payload)
                
                if UIDevice.isPad {
                    vc.modalPresentationStyle = .pageSheet
                    
                    if let sheet = vc.sheetPresentationController {
                        sheet.detents = [.large()]
                        sheet.prefersScrollingExpandsWhenScrolledToEdge = false
                        sheet.prefersGrabberVisible = true
                        sheet.widthFollowsPreferredContentSizeWhenEdgeAttached = true
                        sheet.prefersEdgeAttachedInCompactHeight = true
                    }
                }
                
                self?.present(vc, animated: true)
            })
            .disposed(by: disposeBag)
    }
}
