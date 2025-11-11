import Foundation
import RxSwift
import UserDefaultCoreInterface
import UserDefaultCore

enum CoinType: Equatable {
    case coin
    case subscribe
}

enum CoinError: Error {
    case 코인부족
}

final class CoinUseCase {
    private var currentType: CoinType = .coin {
        didSet {
            currentCoinStateSubject.onNext((currentType, currentCoin))
        }
    }
    
    private var currentCoin: Int = 0 {
        didSet {
            currentCoinStateSubject.onNext((currentType, currentCoin))
        }
    }
    
    private var refillCount: Int = 3
    private let useCase: UserDefaultManagerImpl
    
    private let currentCoinStateSubject = PublishSubject<(CoinType, Int)>()
    
    var currentCoinStateObj: Observable<(CoinType, Int)> {
        return currentCoinStateSubject.asObservable()
    }
    
    init(suiteName: String) {
        useCase = UserDefaultManagerImpl(suiteName: suiteName)
    }
    
    func play() async throws(CoinError) {
        /// 구독형이면 패스
        guard currentType != .subscribe else { return }
        
        guard currentCoin >= 1 else { throw .코인부족 }
        
        currentCoin -= 1
        
        appendUse(coin: 1)
    }
    
    func check() async {
        let list = (useCase.value(for: CoinUseHistory()) ?? []).sorted()
        
        guard let last = list.last, !last.date.isToday else {
            currentCoin += refillCount
            return
        }
        
        let todayUseCount = list.filter { $0.date.isToday }.count
        currentCoin = refillCount - todayUseCount
    }
    
    private func appendUse(coin: Int) {
        var list = (useCase.value(for: CoinUseHistory()) ?? []).sorted()
        
        list.append(CoinUseHistoryItem(date: Date(), coin: coin))
        useCase.set(list, for: CoinUseHistory())
    }
}
