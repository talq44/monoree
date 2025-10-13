import Foundation
import ReactorKit
import RxSwift

enum GameListViewAction {
    case selectItem(at: String)
}

struct GameListViewState {
    var items: [String] = []
}

final class GameListViewReactor {
    
}
