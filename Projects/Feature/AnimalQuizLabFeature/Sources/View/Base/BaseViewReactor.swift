import Foundation
import ReactorKit
import RxSwift

enum BaseViewAction {
    case refresh
}

enum BaseViewMutation {
    case setCoinText(String)
}

struct BaseViewState {
    var coinText: String = "Coin 0"
}

final class BaseViewReactor: Reactor {
    static let shared = BaseViewReactor()
    
    typealias Action = BaseViewAction
    typealias Mutation = BaseViewMutation
    typealias State = BaseViewState
    
    let initialState: BaseViewState
    let coinUseCase: CoinUseCase = CoinUseCase(suiteName: "Coin")
    
    private init() {
        initialState = .init()
    }
}

// MARK: - mutate
extension BaseViewReactor {
    func mutate(action: BaseViewAction) -> Observable<BaseViewMutation> {
        switch action {
        case .refresh:
            return requestRefresh(coinUseCase: coinUseCase)
        }
    }
}

// MARK: - side effect
extension BaseViewReactor {
    private func requestRefresh(coinUseCase: CoinUseCase) -> Observable<BaseViewMutation> {
        return Observable.create { emitter in
            let task = Task { @MainActor in
                do {
                    _ = await coinUseCase.check()
                }
                
                emitter.onCompleted()
            }
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
}

// MARK: - transform
extension BaseViewReactor {
    func transform(mutation: Observable<BaseViewMutation>) -> Observable<BaseViewMutation> {
        
        return .merge([mutation])
    }
}

// MARK: - reduce
extension BaseViewReactor {
    func reduce(state: BaseViewState, mutation: BaseViewMutation) -> BaseViewState {
        var state = state
        
        switch mutation {
        case .setCoinText(let string):
            state.coinText = string
        }
        
        return state
    }
}
