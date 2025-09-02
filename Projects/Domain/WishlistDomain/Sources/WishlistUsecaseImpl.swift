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
    
    func update(_ type: WishlistUpdateType) async {
        switch type {
        case .add(let item):
            await addWishList(item)
        case .delete(let id):
            await deleteWishList(id: id)
        }
    }
    
    private func addWishList(_ item: WishListItem) async {
        
    }
    
    private func deleteWishList(id: String) async {
        
    }
}
