import Foundation
import VersionCheckDomainInterface

final class MockVersionCheckUsecase: VersionCheckUsecase {
    private let result: VersionUpdateResult
    
    init(result: VersionUpdateResult) {
        self.result = result
    }
    
    func checkVersion(_ currentVersion: String) async -> VersionUpdateResult {
        return result
    }
}
