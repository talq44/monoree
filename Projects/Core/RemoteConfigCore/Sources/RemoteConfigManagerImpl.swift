import RemoteConfigCoreInterface
import FirebaseShared

final class RemoteConfigManagerImpl: RemoteConfigManager {
    
    var isInitialized: Bool {
        return true
    }
    
    func fetchVersion() -> any VersionDTO {
        
    }
}
