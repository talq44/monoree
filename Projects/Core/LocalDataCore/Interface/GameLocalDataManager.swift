import Foundation

public protocol GameLocalDataManager {
    func getPlayDates() async -> [Date]
    func getPlayDatesToday(_ date: Date) async -> [Date]
    func putPlayDate(_ date: Date) async
}
