import UserGameSettingDomainInterface
import LocalDataCoreInterface

final class UserLocalDataManagerMock: UserLocalDataManager {
    func addWishList(id: String) async throws { }
    
    func deleteWishList(id: String) async throws { }
    
    func getWishLists() async throws -> [String] { [] }
    
    func questionCount() async -> Int? { 3 }
    
    func setQuestionCount(_ value: Int) async { }
    
    func timePerQuestion() async -> Int? { 3 }
    
    func setTimePerQuestion(_ value: Int) async { }
    
    func teamCount() async -> Int? { 3 }
    
    func setTeamCount(_ value: Int) async { }
}
