import UIKit
import UIKitExtensionShared
import SnapKit
import ReactorKit
import RxSwift
import RxCocoa

final class GameListViewController: BaseViewController {
    private enum Metric {
        static let itemHeight: CGFloat = 72
        static let itemSpacing: CGFloat = Spacing.m
    }
    
    private typealias Cell = GameListItemCell
    
    private let tableView = UITableView()
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
        
        tableView.rowHeight = Metric.itemHeight
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.register(Cell.self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBarCoin()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let animalSymbols: [String] = [
            "bird",
            "bird.fill",
            "bear",
            "bear.fill",
            "cat",
            "cat.fill",
            "dog",
            "dog.fill",
            "hare",
            "hare.fill",
            "tortoise",
            "tortoise.fill",
            "lizard",
            "lizard.fill",
            "fish",
            "fish.fill"
        ]
        
        if let systemName = animalSymbols.randomElement() {
            bindImage(systemName)
        }
    }
    
    private func bindImage(_ systemName: String) {
        let config = UIImage.SymbolConfiguration(pointSize: 128, weight: .bold)
        let image = UIImage(systemName: systemName, withConfiguration: config)
        
        backgroundImageView.image = image
        
        switch Int.random(in: 0..<5) {
        case 0:
            backgroundImageView.addSymbolEffect(.scale)
        case 1:
            backgroundImageView.addSymbolEffect(.appear)
        case 2:
            backgroundImageView.addSymbolEffect(.disappear)
        case 3:
            backgroundImageView.addSymbolEffect(.pulse)
        default:
            backgroundImageView.addSymbolEffect(.bounce)
        }
    }
}

extension GameListViewController: ReactorKit.View {
    typealias Reactor = GameListViewReactor
    
    func bind(reactor: GameListViewReactor) {
        bindAction(reactor: reactor)
        bindState(reactor: reactor)
    }
    
    private func bindAction(reactor: GameListViewReactor) {
        tableView.rx.modelSelected(GameListType.self)
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
                cell.bind(state: item)
            }
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.title }
            .distinctUntilChanged()
            .bind(to: self.rx.title)
            .disposed(by: disposeBag)
    }
}
