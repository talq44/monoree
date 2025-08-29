import Foundation
import RemoteConfigCoreInterface

public protocol GameCompletionUseCase {
    init(remoteConfig: GameConfigManager)
    
    func completeGame() async -> GameCompletionResultType
}
