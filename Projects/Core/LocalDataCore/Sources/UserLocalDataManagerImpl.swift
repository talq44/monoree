import Foundation
import LocalDataCoreInterface

extension LocalDataUsecaseImpl: UserLocalDataManager {
    func addWishList(id: String) async throws {
        var list = (try? await getWishLists()) ?? []
        guard !list.contains(id) else { return }
        list.append(id)
        setLocalData(list, key: .wishlist)
    }
    
    func deleteWishList(id: String) async throws {
        let list = ((try? await getWishLists()) ?? []).filter { $0 != id }
        setLocalData(list, key: .wishlist)
    }
    
    func getWishLists() async throws -> [String] {
        try getLocalData([String].self, key: .wishlist)
    }
    
    func questionCount() async -> Int? {
        getLocalDataOptional(Int.self, key: .questionCount)
    }
    
    func setQuestionCount(_ value: Int) async {
        setLocalData(value, key: .questionCount)
    }
    
    func timePerQuestion() async -> Int? {
        getLocalDataOptional(Int.self, key: .timePerQuestion)
    }
    
    func setTimePerQuestion(_ value: Int) async {
        setLocalData(value, key: .timePerQuestion)
    }
    
    func teamCount() async -> Int? {
        getLocalDataOptional(Int.self, key: .teamCount)
    }
    
    func setTeamCount(_ value: Int) async {
        setLocalData(value, key: .teamCount)
    }
}
