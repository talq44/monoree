import UIKit
import SnapKit
import UIKitExtensionShared
import ReactorKit
import RxSwift
import RxCocoa

final class HomeViewController: BaseViewController {
    typealias Cell = HomeItemCell
    
    private enum Metric {
        static let bannerHeight: CGFloat = 100
        static let singleColumnHeight: CGFloat = 80
        static let itemSpacing: CGFloat = Spacing.s
    }
    
    private let stackView = VStackView()
    private let bannerView = UIView()
    
    // Sections grouped by columns so layout can vary per section
    private var sections: [Section] = []
    
    private struct Section {
        let columns: Int
        let items: [HomeViewState.Item]
    }
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: makeCompositionalLayout())
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(Cell.self, forCellWithReuseIdentifier: String(describing: Cell.self))
        return collectionView
    }()
    
    init(reactor: HomeViewReactor = HomeViewReactor(useFakeRemoteConfig: true)) {
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
            make.directionalEdges.equalTo(view.safeAreaLayoutGuide)
        }
        
        bannerView.snp.makeConstraints { make in
            make.height.equalTo(Metric.bannerHeight)
        }
        
        stackView.addArrangedSubviews(
            collectionView,
            bannerView
        )
        
        bannerView.backgroundColor = .green
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "홈"
        
        setupNavigationBarHome()
        
        reactor?.action.onNext(.refresh)
    }
    
    private func makeCompositionalLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { [weak self] sectionIndex, environment in
            let columns: Int = {
                guard let self = self, sectionIndex < self.sections.count else { return 2 }
                return self.sections[sectionIndex].columns
            }()
            
            let count = max(1, min(3, columns))
            
            if count == 1 {
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .absolute(Metric.singleColumnHeight)
                )
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize = itemSize
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                group.interItemSpacing = .fixed(Metric.itemSpacing)
                
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16)
                section.interGroupSpacing = Metric.itemSpacing
                
                return section
            } else {
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0 / CGFloat(count)),
                    heightDimension: .fractionalWidth(1.0 / CGFloat(count))
                )
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .fractionalWidth(1.0 / CGFloat(count))
                )
                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: groupSize,
                    repeatingSubitem: item,
                    count: count
                )
                group.interItemSpacing = .fixed(Metric.itemSpacing)
                
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16)
                section.interGroupSpacing = Metric.itemSpacing
                
                return section
            }
        }
    }
}

extension HomeViewController: ReactorKit.View {
    typealias Reactor = HomeViewReactor
    
    func bind(reactor: HomeViewReactor) {
        bindAction(reactor: reactor)
        bindState(reactor: reactor)
    }
    
    private func bindAction(reactor: Reactor) {
        collectionView.rx.modelSelected(HomeViewState.Item.self)
            .map { Reactor.Action.selectItem(id: $0.id) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    
    private func bindState(reactor: Reactor) {
        bindStateItems(reactor: reactor)
        bindStateNextPage(reactor: reactor)
    }
    
    private func bindStateItems(reactor: Reactor) {
        reactor.state.map { $0.items }
            .distinctUntilChanged()
            .observe(on: MainScheduler.instance)
            .do(onNext: { [weak self] items in
                guard let self else { return }
                
                let grouped = Dictionary(grouping: items, by: { max(1, min(3, $0.columns)) })
                let sortedKeys = grouped.keys.sorted()
                let sections: [Section] = sortedKeys.map { key in
                    Section(columns: key, items: grouped[key] ?? [])
                }
                
                self.sections = sections
                self.collectionView.setCollectionViewLayout(self.makeCompositionalLayout(), animated: false)
            })
            .bind(to: collectionView.rx.items(
                cellIdentifier: String(describing: Cell.self),
                cellType: Cell.self
            )) { _, item, cell in
                cell.bind(state: item)
            }
            .disposed(by: disposeBag)
    }
    
    private func bindStateNextPage(reactor: Reactor) {
        reactor.pulse(\.$nextPage)
            .compactMap { $0 }
            .subscribe(onNext: { [weak self] payload in
                let vc = GameListViewController(reactor: GameListViewReactor(payload: payload))
                self?.navigationController?.pushViewController(vc, animated: true)
            })
            .disposed(by: disposeBag)
    }
}

