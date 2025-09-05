import Foundation
import WishlistDomainInterface
import AnalyticsCoreInterface
import LocalDataCoreInterface

final actor WishlistUsecaseImpl: @preconcurrency WishlistUsecase {
    private let analytics: AnalyticsManager
    private let localData: LocalDataManager
    private var changedContinuation: AsyncStream<WishlistUpdateType>.Continuation?
    
    lazy var changed: AsyncStream<WishlistUpdateType> = {
        AsyncStream(bufferingPolicy: .bufferingNewest(64)) { continuation in
            self.changedContinuation = continuation
        }
    }()
    
    init(
        analytics: AnalyticsManager,
        localData: LocalDataManager
    ) {
        self.analytics = analytics
        self.localData = localData
    }
    
    deinit {
        changedContinuation?.finish()
    }
    
    func get() async throws(WishlistError) -> [String] {
        do {
            return try await localData.getWishLists()
        } catch {
            throw .unknown
        }
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
            
            changedContinuation?.yield(.add(item))
        } catch {
            throw WishlistError.unknown
        }
    }
    
    private func deleteWishList(id: String) async throws(WishlistError) {
        guard id.isEmpty == false else { throw .invalidId }
        
        do {
            try await localData.deleteWishList(id: id)
            
            changedContinuation?.yield(.delete(id: id))
        } catch {
            throw WishlistError.unknown
        }
    }
}
