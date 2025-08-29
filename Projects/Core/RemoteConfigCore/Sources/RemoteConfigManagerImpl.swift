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
    
    internal func fetchRemoteConfig<T: Decodable>(
        _ type: T.Type,
        key: RemoteConfigKeys
    ) throws -> T {
        let rcValue = remoteConfig.configValue(forKey: key.rawValue)

        if T.self == String.self {
            let v = rcValue.stringValue
            guard !v.isEmpty else { throw RemoteConfigError.unknown }
            
            return v as! T
        } else if T.self == Int.self {
            guard let result = Int(truncating: rcValue.numberValue) as? T else {
                throw RemoteConfigError.unknown
            }
            return result
        } else if T.self == Double.self {
            guard let result = Double(truncating: rcValue.numberValue) as? T else {
                throw RemoteConfigError.unknown
            }
            return result
        } else if T.self == Bool.self {
            guard let result = rcValue.boolValue as? T else {
                throw RemoteConfigError.unknown
            }
            return result
        } else {
            let data = rcValue.dataValue
            guard !data.isEmpty else {
                throw RemoteConfigError.unknown
            }
            return try JSONDecoder().decode(T.self, from: data)
        }
    }
}

