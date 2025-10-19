import Foundation
import ReactorKit
import RxSwift

enum ChargingViewAction {
    
}

struct ChargingViewState: Equatable {
    var freeCoin: Int = 3
}

final class ChargingViewReactor: Reactor {
    typealias Action = ChargingViewAction
    typealias State = ChargingViewState
    
    let initialState: ChargingViewState
    
    init() {
        initialState = .init()
    }
}
