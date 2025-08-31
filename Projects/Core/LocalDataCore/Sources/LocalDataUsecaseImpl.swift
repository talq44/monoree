import Foundation
import LocalDataCoreInterface

final actor LocalDataUsecaseImpl: LocalDataUsecase {
    private let userDefault: UserDefaults
    
    init(userDefault: UserDefaults = .standard) {
        self.userDefault = userDefault
    }
    
    internal func getLocalData<T: Decodable>(
        _ type: T.Type,
        key: LocalDataKey
    ) throws -> T {
        do {
            guard let data = userDefault.data(forKey: key.rawValue) else {
                throw LocalDataError.unknown
            }
            
            let result = try JSONDecoder().decode(T.self, from: data)
            
            return result
        } catch {
            throw error
        }
    }
    
    internal func getLocalDataOptional<T: Decodable>(
        _ type: T.Type,
        key: LocalDataKey
    ) -> T? {
        do {
            return try getLocalData(type, key: key)
        } catch {
            return nil
        }
    }
    
    internal func setLocalData<T: Encodable>(
        _ value: T,
        key: LocalDataKey
    ) {
        guard let data = try? JSONEncoder().encode(value) else { return }
        
        userDefault.set(data, forKey: key.rawValue)
    }
}

extension LocalDataUsecaseImpl: ConfigLocalDataManager {
    func getIDFA() async -> String? {
        getLocalDataOptional(String.self, key: .idfa)
    }
    
    func setIDFA(_ idfa: String) async {
        setLocalData(idfa, key: .idfa)
    }
}

extension LocalDataUsecaseImpl: GameLocalDataManager {
    func getPlayDates() async -> [Date] {
        return getLocalDataOptional([Date].self, key: .gamePlayList) ?? []
    }
    
    func getPlayDatesToday(_ date: Date) async -> [Date] {
        await getPlayDates().filter { item in
            return false
        }
    }
    
    func putPlayDate(_ date: Date) async {
        var list = await getPlayDates()
        list.append(date)
        setLocalData(list, key: .gamePlayList)
    }
}
