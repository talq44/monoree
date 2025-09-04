import Foundation

public protocol UserLocalDataManager {
    func addWishList(id: String) async throws
    func deleteWishList(id: String) async throws
    func getWishLists() async throws -> [String]
    
    func questionCount() async -> Int?
    func setQuestionCount(_ value: Int) async
    
    func timePerQuestion() async -> Int?
    func setTimePerQuestion(_ value: Int) async
    
    func teamCount() async -> Int?
    func setTeamCount(_ value: Int) async
}
