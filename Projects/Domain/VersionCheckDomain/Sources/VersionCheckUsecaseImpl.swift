import Foundation
import VersionCheckDomainInterface
import RemoteConfigCoreInterface

final class VersionCheckUsecaseImpl: VersionCheckUsecase {
    private let remoteVersionConfig: any VersionConfigManager
    
    init(remoteVersionConfig: any VersionConfigManager) {
        self.remoteVersionConfig = remoteVersionConfig
    }
    
    func checkVersion(_ currentVersion: String) async -> VersionUpdateResult {
        do {
            let versionConfig = try await remoteVersionConfig.fetchVersion()
            
            let cur = SemVer(currentVersion)
            let min = SemVer(versionConfig.minVersion)
            let max = SemVer(versionConfig.maxVersion)
            
            guard cur != SemVer("0.0.0") else { return .none }
            
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
