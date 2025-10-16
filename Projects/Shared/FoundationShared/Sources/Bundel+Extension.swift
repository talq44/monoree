import Foundation

public extension Bundle {
    static var marketingVersion: String {
        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
#if DEBUG
        let build = Bundle.main.infoDictionary?["CFBundleVersion"] as? String
        if let version, let build { return "v\(version) (\(build))" }
#else
        if let version { return "v\(version)" }
#endif
        return "버전 정보"
    }
}
