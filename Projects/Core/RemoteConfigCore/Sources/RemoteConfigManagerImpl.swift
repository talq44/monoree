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
        remoteConfig.setDefaults(fromPlist: "remote_config_defaults")
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
    
    private func fetchRemoteConfig<T: Decodable>(_ type: T.Type, key: RemoteConfigKeys) throws -> T {
        do {
            let value = remoteConfig.value(forKey: key.rawValue)
            
            if let data = value as? Data {
                let decoder = JSONDecoder()
                let decodedValue = try decoder.decode(T.self, from: data)
                
                return decodedValue
            } else {
                fatalError("Could not decode remote config value for key \(key)")
            }
        } catch {
            throw error
        }
    }
    
    func fetchVersion() throws -> any RemoteConfigCoreInterface.VersionDTO {
        do {
            let response = try fetchRemoteConfig(
                VersionDTOImpl.self,
                key: .version
            )
            
            return response
        } catch {
            throw error
        }
    }
}
