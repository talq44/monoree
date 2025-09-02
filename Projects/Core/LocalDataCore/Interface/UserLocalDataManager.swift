import Foundation

public protocol UserLocalDataManager {
    func addWishList(id: String) async throws
    func deleteWishList(id: String) async throws
    func getWishLists() async throws -> [String]
}
