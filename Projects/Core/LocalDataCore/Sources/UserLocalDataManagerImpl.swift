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
}
