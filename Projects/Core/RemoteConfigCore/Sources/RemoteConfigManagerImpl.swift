import RemoteConfigCoreInterface
import FirebaseSPMShared
import FirebaseRemoteConfig

final class RemoteConfigManagerImpl: RemoteConfigManager {
    private let remoteConfig: RemoteConfig
    
    init() {
        self.remoteConfig = RemoteConfig.remoteConfig()
        
        let settings = RemoteConfigSettings()
#if DEBUG
        settings.minimumFetchInterval = 0
#else
        settings.minimumFetchInterval = 3600
#endif
        remoteConfig.configSettings = settings
        
    }
    
    private func configureAppFeatures() {
        
    }
    
    func fetch() async throws {
        do {
            let fetchAndActivate = try await remoteConfig.fetchAndActivate()
            switch fetchAndActivate {
            case .successFetchedFromRemote:
                break
            case .successUsingPreFetchedData:
                break
            case .error:
                throw RemoteConfigError.unknown
            @unknown default:
                break
            }
        } catch {
            throw error
        }
    }
    
    func fetchVersion() throws -> any RemoteConfigCoreInterface.VersionDTO {
        let key = RemoteConfigKeys.version
        
        do {
            let response = try remoteConfig
                .configValue(forKey: key.rawValue)
                .decoded(asType: VersionDTOImpl.self)
            
            return response
        } catch {
            throw error
        }
    }
}
