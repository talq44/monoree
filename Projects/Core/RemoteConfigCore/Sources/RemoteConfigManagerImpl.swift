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
            let rcValue = remoteConfig.configValue(forKey: key.rawValue)
            let data = rcValue.dataValue
            guard !data.isEmpty else {
                // TODO: 필요 시 전용 에러 케이스(keyNotFound/invalidData 등)로 세분화
                throw RemoteConfigError.unknown
            }
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
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
