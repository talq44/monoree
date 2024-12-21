//
//  MainTabViewController.swift
//  Remember
//
//  Created by 박창규 on 12/3/24.
//

import UIKit

import SnapKit
import ReactorKit
import RxSwift
import RxCocoa
import DesignSystem

final class MainTabViewController: UIViewController, ReactorKit.View {
    typealias Reactor = MainTabViewReactor
    typealias Cell = PageCell
    private let CellIdentifier = "PageCell"
    
    private enum Metric {
        static let tabHeigt = TabsView.height
        static let itemWidth: CGFloat = UIScreen.main.bounds.width
        static var safeAreaHeight: CGFloat {
            guard let window = UIApplication.shared.windows.first else {
                return 0
            }
            let windowHeight = window.bounds.height
            let insets = window.safeAreaInsets
            return windowHeight - insets.top - insets.bottom
        }
        
        static func itemHeight(_ viewController: UIViewController) -> CGFloat {
            let naviBar = viewController.navigationController?.navigationBar
            let naviHeight = naviBar?.bounds.height ?? 0
            return safeAreaHeight - tabHeigt - naviHeight
        }
    }
    
    private let tabsView: TabsView
    private let collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewLayout()
    )
    private let searchVC: UIViewController
    private let bookmarkVC: UIViewController
    
    private let tabs: [MainTabType]
    private let viewControllers: [UIViewController]
    
    var disposeBag: RxSwift.DisposeBag = DisposeBag()
    
    init(
        reactor: MainTabViewReactor,
        searchVC: UIViewController,
        bookmarkVC: UIViewController
    ) {
        self.tabs = reactor.currentState.tabs
        self.searchVC = searchVC
        self.bookmarkVC = bookmarkVC
        self.viewControllers = [searchVC, bookmarkVC]
        let tabsViewState = TabsViewState(
            items: tabs.map { tab in 
                return TabsViewItem(title: tab.name, isSelected: false)
            }
        )
        self.tabsView = TabsView(state: tabsViewState)
        super.init(nibName: nil, bundle: nil)
        self.reactor = reactor
    }
    
    override func loadView() {
        super.loadView()
        self.view.addSubview(self.tabsView)
        self.view.addSubview(self.collectionView)
        self.tabsView.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide)
            $0.horizontalEdges.equalToSuperview()
        }
        self.collectionView.snp.makeConstraints {
            $0.top.equalTo(self.tabsView.snp.bottom)
            $0.horizontalEdges.equalTo(self.view.safeAreaLayoutGuide)
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }
        self.addConfigure()
        
        self.addChild(searchVC)
        self.addChild(bookmarkVC)
        self.searchVC.didMove(toParent: self)
        self.bookmarkVC.didMove(toParent: self)
    }
    
    private func addConfigure() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = .init(
            width: Metric.itemWidth,
            height: Metric.itemHeight(self)
        )
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal

        self.collectionView.isPagingEnabled = true
        self.collectionView.showsHorizontalScrollIndicator = false
        self.collectionView.collectionViewLayout = layout
        self.collectionView.alwaysBounceVertical = false
        self.collectionView.register(
            Cell.self,
            forCellWithReuseIdentifier: CellIdentifier
        )
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func bind(reactor: Reactor) {
        self.bindAction(reactor: reactor)
        self.bindState(reactor: reactor)
    }
    
    private func bindAction(reactor: Reactor) {
        self.tabsView.didSelectedItem = { [weak self] index in
            guard let tab = self?.tabs[index] else { return }
            reactor.action.onNext(.didSelectTab(tab))
        }
    }
    
    private func bindState(reactor: Reactor) {
        reactor.state.map { $0.currentTab }
            .skip(1)
            .distinctUntilChanged()
            .observe(on: MainScheduler.instance)
            .bind(onNext: { [weak self] tab in
                guard let row = self?.tabs.firstIndex(of: tab) else { return }
                self?.tabsView.selectItem(at: row)
                let visibleRow = self?.collectionView.indexPathsForVisibleItems
                    .first?.row
                
                guard visibleRow != row else { return }
                
                self?.collectionView.setContentOffset(
                    CGPoint(x: Metric.itemWidth * CGFloat(row), y: 0),
                    animated: true
                )
            })
            .disposed(by: self.disposeBag)
        
        reactor.state.map { $0.title }
            .distinctUntilChanged()
            .observe(on: MainScheduler.instance)
            .bind(onNext: { [weak self] title in
                self?.title = title
            })
            .disposed(by: self.disposeBag)
    }
}

extension MainTabViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return self.tabs.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CellIdentifier,
            for: indexPath
        ) as? Cell else {
            return UICollectionViewCell()
        }
        
        let vc = self.viewControllers[indexPath.row]
        
        cell.bind(state: vc.view)
        
        return cell
    }
}

extension MainTabViewController: UICollectionViewDelegate { }

extension MainTabViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let visibleIndex = Int(collectionView.contentOffset.x / collectionView.bounds.width)
        
        let tab = self.tabs[visibleIndex]
        self.reactor?.action.onNext(.didSelectTab(tab))
    }
}
