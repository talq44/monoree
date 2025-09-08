import Foundation

public protocol VersionCheckUsecase {
    func checkVersion(_ currentVersion: String) -> VersionUpdateResult
}
