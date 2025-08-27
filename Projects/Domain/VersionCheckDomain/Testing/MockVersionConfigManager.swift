import VersionCheckDomainInterface
import RemoteConfigCoreInterface

enum VersionCheckTestCase {
    case error
    case normal(
        appStoreUrl: String,
        minVersion: String,
        maxVersion: String
    )
}

final class MockVersionConfigManager: VersionConfigManager {
    private var testCase: VersionCheckTestCase = .error
    
    func setup(testCase: VersionCheckTestCase) {
        self.testCase = testCase
    }
    
    func fetchVersion() throws -> any RemoteConfigCoreInterface.VersionDTO {
        switch testCase {
        case .error:
            throw RemoteConfigError.unknown
        case .normal(let appStoreUrl, let minVersion, let maxVersion):
            return MockVersionDTO(
                appStoreUrl: appStoreUrl,
                minVersion: minVersion,
                maxVersion: maxVersion
            )
        }
    }
}

struct MockVersionDTO: VersionDTO {
    let appStoreUrl: String
    let minVersion: String
    let maxVersion: String
}
