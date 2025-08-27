import Foundation
import RemoteConfigCoreInterface

public protocol VersionCheckUsecase {
    init(remoteConfig: RemoteConfigManager)
    func checkVersion() -> VersionUpdateResult
}
