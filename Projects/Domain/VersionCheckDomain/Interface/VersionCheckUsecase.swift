import Foundation
import RemoteConfigCoreInterface

public protocol VersionCheckUsecase {
    init(remoteVersionConfig: VersionConfigManager)
    func checkVersion(_ currentVersion: String) -> VersionUpdateResult
}
