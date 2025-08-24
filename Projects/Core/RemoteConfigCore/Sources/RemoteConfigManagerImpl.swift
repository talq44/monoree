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
    
    private func fetchRemoteConfig<T: Decodable>(_ type: T.Type, key: RemoteConfigKeys) throws -> T {
        let rcValue = remoteConfig.configValue(forKey: key.rawValue)

        // 1) Primitive fast-path
        if T.self == String.self {
            let v = rcValue.stringValue
            guard !v.isEmpty else { throw RemoteConfigError.unknown }
            return v as! T
        }
        if T.self == Int.self {
            return Int(truncating: rcValue.numberValue) as! T
        }
        if T.self == Double.self {
            return Double(truncating: rcValue.numberValue) as! T
        }
        if T.self == Bool.self {
            return rcValue.boolValue as! T
        }

        // 2) JSON 객체/배열 디코딩
        let data = rcValue.dataValue
        guard !data.isEmpty else {
            // NOTE: 데이터가 비어 있습니다. 기본값(setDefaults) 또는 서버 설정을 확인하세요.
            throw RemoteConfigError.unknown
        }
        return try JSONDecoder().decode(T.self, from: data)
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
