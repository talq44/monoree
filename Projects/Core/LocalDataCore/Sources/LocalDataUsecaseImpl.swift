import Foundation
import LocalDataCoreInterface

final actor LocalDataUsecaseImpl: LocalDataUsecase {
    private func getLocalData<T: Decodable>(
        _ type: T.Type,
        key: LocalDataKey
    ) throws -> T {
        do {
            guard let data = UserDefaults.standard.data(forKey: key.rawValue) else {
                throw LocalDataError.unknown
            }
            
            let result = try JSONDecoder().decode(T.self, from: data)
            
            return result
        } catch {
            throw error
        }
    }
    
    private func getLocalDataOptional<T: Decodable>(
        _ type: T.Type,
        key: LocalDataKey
    ) -> T? {
        do {
            return try getLocalData(type, key: key)
        } catch {
            return nil
        }
    }
    
    private func setLocalData<T: Encodable>(
        _ value: T,
        key: LocalDataKey
    ) {
        guard let data = try? JSONEncoder().encode(value) else { return }
        
        UserDefaults.standard.set(data, forKey: key.rawValue)
    }
}

extension LocalDataUsecaseImpl: @preconcurrency ConfigLocalDataManager {
    var idfa: String? {
        get {
            getLocalDataOptional(String.self, key: .idfa)
        }
        set {
            guard let newValue else { return }
            
            setLocalData(newValue, key: .idfa)
        }
    }
}
