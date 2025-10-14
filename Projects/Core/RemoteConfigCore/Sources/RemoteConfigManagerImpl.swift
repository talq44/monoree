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
    
    func fetchAndActivate() async throws {
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
        stringKey: String
    ) throws -> T {
        let rcValue = remoteConfig.configValue(forKey: stringKey)
        
        switch T.self {
        case is String.Type:
            guard let value = rcValue.stringValue as? T else {
                throw RemoteConfigError.unknown
            }
            return value
        case is Int.Type:
            guard let result = Int(truncating: rcValue.numberValue) as? T else {
                throw RemoteConfigError.unknown
            }
            return result
        case is Double.Type:
            guard let result = Double(truncating: rcValue.numberValue) as? T else {
                throw RemoteConfigError.unknown
            }
            return result
        case is Bool.Type:
            guard let result = rcValue.boolValue as? T else {
                throw RemoteConfigError.unknown
            }
            return result
        default:
            let data = rcValue.dataValue
            guard !data.isEmpty else {
                throw RemoteConfigError.unknown
            }
            return try JSONDecoder().decode(T.self, from: data)
        }
    }
    
    internal func fetchRemoteConfig<T: Decodable>(
        _ type: T.Type,
        key: RemoteConfigKeys
    ) throws -> T {
        return try fetchRemoteConfig(type, stringKey: key.rawValue)
    }
}
