import Foundation

public protocol ConfigLocalDataManager {
    func getIDFA() async -> String?
    func setIDFA(_ idfa: String) async
    func getFirstAllowedIDFADate() async -> Date?
    func setFirstAllowedIDFADate() async
}
