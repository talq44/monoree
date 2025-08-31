import Foundation

public protocol GameLocalDataManager {
    func getPlayDates() async -> [Date]
    func getPlayDatesToday() async -> [Date]
    func putPlayDate() async
}
