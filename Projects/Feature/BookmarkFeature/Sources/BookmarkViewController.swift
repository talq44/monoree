//
//  BookmarkViewController.swift
//  BookmarkFeature
//
//  Created by 박창규 on 12/2/24.
//

import UIKit

import DesignSystem

import SnapKit
import RxSwift
import RxCocoa
import ReactorKit

class BookmarkViewController: UIViewController, ReactorKit.View {
    typealias Reactor = BookmarkViewReactor
    
    private enum Metric {
        static let horizontalMargin: CGFloat = .horizontalMargin
    }
    
    var disposeBag: RxSwift.DisposeBag = DisposeBag()
    
    private let stackView = UIStackView()
    private let searchBar = UISearchBar()
    private let contentsStackView = UIStackView()
    private let firstView = WelcomView(type: .bookmark)
    private let emptyView = EmptyView(type: .bookmark)
    private let listView = ListView(style: .grouped)
    private let loadingView = UIActivityIndicatorView()
    
    private let contentViews: [UIView]
    
    init(reactor: Reactor) {
        self.contentViews = [
            firstView,
            emptyView,
            listView
        ]
        super.init(nibName: nil, bundle: nil)
        self.reactor = reactor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        self.view.addSubview(stackView)
        self.view.addSubview(loadingView)
        self.addConfigure()
        
        self.stackView.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide)
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide)
            $0.horizontalEdges.equalToSuperview()
        }
        
        self.loadingView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        self.stackView.addArrangedSubview(searchBar)
        self.stackView.addArrangedSubview(contentsStackView)
        self.contentViews.forEach {
            self.contentsStackView.addArrangedSubview($0)
        }
        listView.backgroundColor = .blue
    }
    
    private func addConfigure() {
        self.stackView.axis = .vertical
        self.stackView.distribution = .fill
        
        self.contentsStackView.axis = .vertical
        self.contentsStackView.alignment = .fill
        self.contentsStackView.distribution = .fillProportionally
        
        self.searchBar.delegate = self
        
        self.loadingView.style = .large
        self.loadingView.hidesWhenStopped = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.reactor?.action.onNext(.viewDidLoad)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
    }
    
    func bind(reactor: Reactor) {
        self.bindAction(reactor: reactor)
        self.bindState(reactor: reactor)
    }
    
    private func bindAction(reactor: Reactor) {
        self.listView.didSelectBookmarkAtId = { id in
            reactor.action.onNext(.selectBookmark(id: id))
        }
        
        self.listView.didRefresh = { [weak self] in
            let query = self?.searchBar.text ?? ""
            reactor.action.onNext(.refresh(query: query))
        }
    }
    
    private func bindState(reactor: Reactor) {
        reactor.state
            .distinctUntilChanged()
            .observe(on: MainScheduler.instance)
            .bind(onNext: { [weak self] state in
                
                switch state {
                case .first:
                    self?.bindStateFirst()
                    
                case .loading:
                    self?.bindStateLoading()
                    
                case .noResults:
                    self?.bindStateEmpty()
                    
                case .results(let items):
                    self?.bindStateList(items: items)
                    
                case .error(let message):
                    self?.bindStateError(message: message)
                }
            })
            .disposed(by: self.disposeBag)
    }
    
    private func bindStateLoading() {
        self.changeLoadingState(isLoading: true)
    }
    
    private func bindStateFirst() {
        self.changeLoadingState(isLoading: false)
        self.changeViewHidden(view: self.firstView)
    }
    
    private func bindStateEmpty() {
        self.changeLoadingState(isLoading: false)
        self.changeViewHidden(view: self.emptyView)
    }
    
    private func bindStateList(items: [BookmarkViewItem]) {
        self.changeLoadingState(isLoading: false)
        self.changeViewHidden(view: self.listView)
        
        self.listView.bind(state: items.map {
            return ListItem(
                id: $0.id,
                imageURL: $0.imageURL,
                name: $0.name,
                isBookmarked: $0.isBookmarked
            )
        })
    }
    
    private func bindStateError(message: String) {
        let alert = UIAlertController(
            title: "알림",
            message: message,
            preferredStyle: .alert
        )
        
        let action = UIAlertAction(title: "확인", style: .default)
        alert.addAction(action)
        
        self.present(alert, animated: true)
    }
    
    private func changeLoadingState(isLoading: Bool) {
        if isLoading {
            self.loadingView.startAnimating()
        } else {
            self.loadingView.stopAnimating()
        }
    }
    
    private func changeViewHidden(view: UIView) {
        self.contentViews.filter { $0 != view }
            .forEach { $0.isHidden = true }
        view.isHidden = false
    }
}

extension BookmarkViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.reactor?.action.onNext(.inputSearch(query: searchText))
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
        self.reactor?.action.onNext(.didSelectSearch(query: searchText))
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
        self.reactor?.action.onNext(.didSelectSearch(query: searchText))
        self.view.endEditing(true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.reactor?.action.onNext(.didSelectSearch(query: ""))
        self.view.endEditing(true)
    }
}

@available(iOS 17.0, *)
#Preview("first") {
    let reactor = BookmarkViewReactor(initialState: .first)
    let vc = BookmarkViewController(reactor: reactor)
    return vc
}

@available(iOS 17.0, *)
#Preview("noResults") {
    let reactor = BookmarkViewReactor(initialState: .noResults)
    let vc = BookmarkViewController(reactor: reactor)
    return vc
}

@available(iOS 17.0, *)
#Preview("results") {
    let reactor = BookmarkViewReactor(initialState: .results(items: []))
    let vc = BookmarkViewController(reactor: reactor)
    return vc
}

@available(iOS 17.0, *)
#Preview("loading") {
    let reactor = BookmarkViewReactor(initialState: .loading)
    let vc = BookmarkViewController(reactor: reactor)
    return vc
}
