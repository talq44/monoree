import Foundation
import VersionCheckDomainInterface
import RemoteConfigCoreInterface

final class VersionCheckUsecaseImpl: VersionCheckUsecase {
    private let remoteConfig: RemoteConfigManager
    
    init(remoteConfig: any RemoteConfigCoreInterface.RemoteConfigManager) {
        self.remoteConfig = remoteConfig
    }
    
    func checkVersion(_ currentVersion: String) -> VersionCheckDomainInterface.VersionUpdateResult {
        do {
            let versionConfig = try remoteConfig.fetchVersion()
            
            let cur = SemVer(currentVersion)
            let min = SemVer(versionConfig.minVersion)
            let max = SemVer(versionConfig.maxVersion)
            
            // Rules:
            // - cur < min  => required update
            // - min <= cur < max => optional update (recommended)
            // - cur >= max => none
            if cur < min {
                return .required(url: versionConfig.appStoreUrl)
            } else if cur < max {
                return .optional(url: versionConfig.appStoreUrl)
            } else {
                return .none
            }
        } catch {
            return .none
        }
    }
}
