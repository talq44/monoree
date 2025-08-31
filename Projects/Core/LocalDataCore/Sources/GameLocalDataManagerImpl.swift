import Foundation
import LocalDataCoreInterface
import FoundationShared

extension LocalDataUsecaseImpl: GameLocalDataManager {
    func getPlayDates() async -> [Date] {
        return getLocalDataOptional([Date].self, key: .gamePlayList) ?? []
    }
    
    func getPlayDatesToday() async -> [Date] {
        await getPlayDates().filter { item in
            return item.isInToday
        }
    }
    
    func putPlayDate() async {
        var list = await getPlayDates()
        list.append(Date())
        
        setLocalData(list, key: .gamePlayList)
    }
}
