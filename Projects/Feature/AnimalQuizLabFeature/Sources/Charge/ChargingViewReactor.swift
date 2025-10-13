import Foundation
import ReactorKit
import RxSwift

enum ChargingViewAction {
    
}

struct ChargingViewState: Equatable {
    var freeCoin: Int = 3
    var chargeCoin: Int = 0
}

final class ChargingViewReactor: Reactor {
    typealias Action = ChargingViewAction
    typealias State = ChargingViewState
    
    let initialState: ChargingViewState
    
    init() {
        initialState = .init()
    }
}
