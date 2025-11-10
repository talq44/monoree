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
            currentTypeSubject.onNext(currentType)
        }
    }
    
    private var currentCoin: Int = 0 {
        didSet {
            currentCoinSubject.onNext(currentCoin)
        }
    }
    
    private var refillCount: Int = 3
    private let useCase: UserDefaultManagerImpl
    
    private let currentTypeSubject = PublishSubject<CoinType>()
    private let currentCoinSubject = PublishSubject<Int>()
    
    var currentTypeObj: Observable<CoinType> {
        return currentTypeSubject.asObservable()
    }
    
    var currentCoinObj: Observable<Int> {
        return currentCoinSubject.asObservable()
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
        let value = useCase.value(for: CoinHistory())
        
        guard let list = value?.sorted(), let last = list.last, !last.date.isToday else {
            currentCoin += refillCount
            return
        }
        
        let todayUseCount = list.filter { $0.date.isToday }.count
        currentCoin = refillCount - todayUseCount
    }
    
    private func appendUse(coin: Int) {
        let value = useCase.value(for: CoinHistory())
        guard var list = value?.sorted() else { return }
        
        list.append(CoinHistoryItem(date: Date(), coin: coin))
        useCase.set(list, for: CoinHistory())
    }
}
