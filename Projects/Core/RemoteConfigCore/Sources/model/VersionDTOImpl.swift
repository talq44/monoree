import Foundation
import RemoteConfigCoreInterface

struct VersionDTOImpl: VersionDTO {
    let appStoreUrl: String
    let minVersion: String
    let maxVersion: String
}
