import Foundation
import GameCompletionDomainInterface
import LocalDataCoreInterface
import FoundationShared

final class GameLocalDataManagerMock: GameLocalDataManager {
    var dates: [Date] = []
    
    func setup(_ beforeCall: Int) {
        for _ in 0..<beforeCall {
            dates.append(Date())
        }
    }
    
    func getPlayDates() async -> [Date] {
        return dates
    }
    
    func getPlayDatesToday() async -> [Date] {
        return dates.filter { $0.isInToday }
    }
    
    func putPlayDate() async {
        dates.append(Date())
    }
}
