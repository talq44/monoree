import ComposableArchitecture
import GamePlayFeatureInterface
import SwiftUI

public final class GamePlayServiceImpl: GamePlayService {
    private let store: StoreOf<GamePlayReducer>
    private let gamePlayView: GamePlayView
    
    public init(
        gameTypes: [GamePlayType],
        timeInterval: TimeInterval,
        teamName: String?
    ) {
        self.store = Store(
            initialState: GamePlayReducer.State(
                gameTypes: gameTypes,
                timeInterval: timeInterval
            )
        ) {
            GamePlayReducer()
        }
        
        self.gamePlayView = GamePlayView(store: store)
    }
    
    public func view() -> AnyView {
        AnyView(self.gamePlayView)
    }
}
