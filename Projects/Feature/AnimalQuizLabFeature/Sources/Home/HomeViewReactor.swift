import Foundation
import ReactorKit
import RxSwift
import RemoteConfigCoreInterface

enum HomeViewAction {
    case refresh
    case selectItem(id: String)
}

enum HomeViewMutation {
    case setItems([HomeViewState.Item])
    case setIsShowBanner(Bool)
    case setError(message: String)
}

struct HomeViewState {
    struct Item: Equatable, Identifiable {
        let id: String
        let title: String
        let subTitle: String?
        let backgroundColor: String?
        let imageURL: String?
        let itemCategory: String?
        let itemCategory2: String?
        var itemsCount: Int
        let columns: Int
    }
    
    var items: [Item] = []
    var isShowBanner: Bool = false
    @Pulse var errorMessage: String?
}

final class HomeViewReactor: Reactor {
    typealias Action = HomeViewAction
    typealias Mutation = HomeViewMutation
    typealias State = HomeViewState
    
    let initialState: HomeViewState
    private let remoteConfig: HomeConfigManager
    
    init(remoteConfig: HomeConfigManager) {
        initialState = .init()
        
        self.remoteConfig = remoteConfig
    }
}

// MARK: - mutate
extension HomeViewReactor {
    func mutate(action: HomeViewAction) -> Observable<HomeViewMutation> {
        switch action {
        case .refresh:
            return mutateRefresh(remoteConfig: remoteConfig)
            
        case .selectItem(let id):
            return .empty()
        }
    }
}

// MARK: - mutate
extension HomeViewReactor {
    private func mutateRefresh(
        remoteConfig: HomeConfigManager
    ) -> Observable<HomeViewMutation> {
        return Observable.create { emitter in
            Task { @MainActor in
                do {
                    let dto = try await remoteConfig.fetchHome(.animal)
                    
                    emitter.onNext(.setIsShowBanner(dto.isShowBanner))
                    emitter.onNext(.setItems(dto.convertItems))
                } catch {
                    emitter.onNext(.setError(message: "네트워크가 불안정합니다. 잠시후에 다시 시도해주세요."))
                }
                
                emitter.onCompleted()
            }
            
            return Disposables.create()
        }
    }
}

// MARK: - reduce
extension HomeViewReactor {
    func reduce(state: HomeViewState, mutation: HomeViewMutation) -> HomeViewState {
        var state = state
        
        switch mutation {
        case .setItems(let items):
            state.items = items
            
        case .setIsShowBanner(let isShowBanner):
            state.isShowBanner = isShowBanner
            
        case .setError(let message):
            state.errorMessage = message
        }
        
        return state
    }
}

extension HomeDTO {
    var convertItems: [HomeViewState.Item] {
        return items.map { item in
            return HomeViewState.Item(
                id: item.id,
                title: item.title,
                subTitle: item.subTitle,
                backgroundColor: item.backgroundColor,
                imageURL: item.imageURL,
                itemCategory: item.itemCategory,
                itemCategory2: item.itemCategory2,
                itemsCount: 0,
                columns: item.columns
            )
        }
    }
}
