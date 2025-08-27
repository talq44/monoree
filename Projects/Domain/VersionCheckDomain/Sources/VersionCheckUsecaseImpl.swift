import Foundation
import VersionCheckDomainInterface
import RemoteConfigCoreInterface

final class VersionCheckUsecaseImpl: VersionCheckUsecase {
    private let remoteVersionConfig: VersionConfigManager
    
    init(remoteVersionConfig: any VersionConfigManager) {
        self.remoteVersionConfig = remoteVersionConfig
    }
    
    func checkVersion(_ currentVersion: String) -> VersionUpdateResult {
        do {
            let versionConfig = try remoteVersionConfig.fetchVersion()
            
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
