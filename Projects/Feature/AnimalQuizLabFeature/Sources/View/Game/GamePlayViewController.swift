import UIKit
import UIKitExtensionShared
import SnapKit
import ReactorKit
import RxSwift
import RxCocoa

final class GamePlayViewController: BaseViewController {
    private let itemView = GameContentView(style: .image)
    
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
        
        view.addSubview(itemView)
        
        itemView.snp.makeConstraints { make in
            make.directionalEdges.equalTo(view.safeAreaLayoutGuide).inset(Spacing.m)
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
        reactor.state.compactMap { $0.items.first }
            .distinctUntilChanged()
            .withUnretained(self)
            .subscribe(onNext: { vc, item in
                vc.itemView.bind(state: GameContentView.State(
                    gameItem: item,
                    didSelectAnswer: { row in
                        print("row \(row)")
                    })
                )
            })
            .disposed(by: disposeBag)
    }
}
