import Foundation
import ComposableArchitecture

@Reducer
struct HomeFeature {
    @ObservableState
    struct State {
        var list: [HomeSection] = []
    }
    
    enum Action {
        case refresh
        case selectSectionAt(id: String)
        case selectItemAt(id: String)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .refresh:
                return .none
            case .selectSectionAt(let id):
                guard let section = state.list
                    .first(where: { $0.id == id }) else {
                    return .none
                }
                
                guard section.sectionType.isShownDetailList else {
                    return .none
                }
                
                return .none
            case .selectItemAt(let id):
                guard let item = state.list.flatMap( \.items )
                    .first(where: { $0.id == id }) else {
                    return .none
                }
                
                return .none
            }
        }
    }
}
