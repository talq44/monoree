import Foundation
import WishlistDomainInterface
import AnalyticsCoreInterface
import LocalDataCoreInterface

final actor WishlistUsecaseImpl: WishlistUsecase {
    private let analytics: AnalyticsProtocol
    private let localData: LocalDataManager
    
    init(
        analytics: AnalyticsProtocol,
        localData: LocalDataManager
    ) {
        self.analytics = analytics
        self.localData = localData
    }
    
    func update(_ type: WishlistUpdateType) async throws(WishlistError) {
        switch type {
        case .add(let item):
            try await addWishList(item)
        case .delete(let id):
            try await deleteWishList(id: id)
        }
    }
    
    private func addWishList(_ item: WishListItem) async throws(WishlistError) {
        guard item.id.isEmpty == false else { throw .invalidId }
        
        do {
            try await localData.addWishList(id: item.id)
            
            analytics.sendEvent(.add_to_wishlist(
                AddToWishlist(items: [
                    ListItem(item_id: item.id, item_name: item.name)
                ])
            ))
        } catch {
            throw WishlistError.unknown
        }
    }
    
    private func deleteWishList(id: String) async throws(WishlistError) {
        guard id.isEmpty == false else { throw .invalidId }
        
        do {
            try await localData.deleteWishList(id: id)
        } catch {
            throw WishlistError.unknown
        }
    }
}
