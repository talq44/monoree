import UserGameSettingDomainInterface
import LocalDataCoreInterface

final class UserLocalDataManagerMock: UserLocalDataManager {
    private var testType: NormalIntTestType = .normal(3)
    
    func setup(testType: NormalIntTestType) {
        self.testType = testType
    }
    
    func addWishList(id: String) async throws { }
    
    func deleteWishList(id: String) async throws { }
    
    func getWishLists() async throws -> [String] { [] }
    
    func questionCount() async -> Int? { testType.value }
    
    func setQuestionCount(_ value: Int) async {
        testType = .normal(value)
    }
    
    func timePerQuestion() async -> Int? { testType.value }
    
    func setTimePerQuestion(_ value: Int) async {
        testType = .normal(value)
    }
    
    func teamCount() async -> Int? { testType.value }
    
    func setTeamCount(_ value: Int) async {
        testType = .normal(value)
    }
}
