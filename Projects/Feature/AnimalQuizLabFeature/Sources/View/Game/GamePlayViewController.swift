import UIKit
import UIKitExtensionShared
import SnapKit
import ReactorKit
import RxSwift
import RxCocoa
import RxThirdKit

final class GamePlayViewController: BaseViewController {
    private typealias Cell = GamePlayItemCell
    
    private let stackView = VStackView()
    private let topContentView = UIView()
    private let topTextStackView = HStackView()
    private let currentCountLabel = BaseLabel("0", style: .title3)
    private let totalPageLabel = BaseLabel("0", style: .title3)
    private let collectionView: UICollectionView = {
        // Compositional layout with horizontal paging, one full-screen item per page
        let layout = UICollectionViewCompositionalLayout { (_, _) -> NSCollectionLayoutSection? in
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)
            )
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)
            )
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .groupPaging
            section.contentInsets = .zero
            section.interGroupSpacing = 0
            return section
        }

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(Cell.self)
        return collectionView
    }()
    
    init(reactor: GamePlayViewReactor) {
        super.init(nibName: nil, bundle: nil)
        
        self.reactor = reactor
    }
    
    @MainActor
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        
        view.addSubview(stackView)
        
        stackView.addArrangedSubviews(
            topContentView.addSubviews(
                topTextStackView.addArrangedSubviews(
                    currentCountLabel,
                    BaseLabel("/", style: .title3),
                    totalPageLabel
                )
            ),
            collectionView
        )
        
        stackView.snp.makeConstraints { make in
            make.directionalEdges.equalTo(view.safeAreaLayoutGuide).inset(Spacing.m)
        }
        
        topTextStackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.lessThanOrEqualTo(64)
        }
        
        collectionView.snp.makeConstraints { make in
            make.height.greaterThanOrEqualTo(100) // allow it to expand
        }
    }
}

// MARK: - Reactor
extension GamePlayViewController: ReactorKit.View {
    typealias Reactor = GamePlayViewReactor
    
    func bind(reactor: GamePlayViewReactor) {
        bindAction(reactor: reactor)
        bindState(reactor: reactor)
    }
    
    private func bindAction(reactor: GamePlayViewReactor) {
        rx.viewDidLoad
            .map { Reactor.Action.refresh }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    
    private func bindState(reactor: GamePlayViewReactor) {
        reactor.state.compactMap { $0.totalPage.toString }
            .distinctUntilChanged()
            .bind(to: totalPageLabel.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.items }
            .distinctUntilChanged()
            .bind(to: collectionView.rx.items(
                cellIdentifier: Cell.reuseIdentifier,
                cellType: Cell.self
            )) { row, item, cell in
                cell.bind(state: GameContentView.State(
                    gameItem: item,
                    didSelectAnswer: { row in
                        print("row \(row)")
                    })
                )
            }
            .disposed(by: disposeBag)
    }
}
