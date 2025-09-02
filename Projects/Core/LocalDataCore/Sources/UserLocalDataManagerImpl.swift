import Foundation
import LocalDataCoreInterface

extension LocalDataUsecaseImpl: UserLocalDataManager {
    func addWishList(id: String) async throws {
        do {
            var list = try await getWishLists()
            list.append(id)
            
            setLocalData(list, key: .wishlist)
        } catch {
            throw error
        }
    }
    
    func deleteWishList(id: String) async throws {
        do {
            let list = try await getWishLists().filter { $0 != id }
            
            setLocalData(list, key: .wishlist)
        } catch {
            throw error
        }
    }
    
    func getWishLists() async throws -> [String] {
        try getLocalData([String].self, key: .wishlist)
    }
}
