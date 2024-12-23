import Foundation

import AnalyticsCoreInterface
import ViewItemDomainInterface

final class ViewItemRepositoryImpl:ViewItemRepository {
    
    private let analytics: AnalyticsCoreInterface.AnalyticsProtocol
    
    init(analytics: AnalyticsCoreInterface.AnalyticsProtocol) {
        self.analytics = analytics
    }
    
    func send(_ input: any ViewItemInput) {
        let items = self.toAnalytics(
            input.items,
            itemListId: input.itemList.itemListId,
            itemListName: input.itemList.itemListName
        )
        
        let viewItem = ViewItem(items: items)
        
        self.analytics.sendEvent(.view_item(viewItem))
    }
    
    private func toAnalytics(
        _ items: [ViewItemDomainInterface.DetailItem],
        itemListId: String?,
        itemListName: String?
    ) -> [AnalyticsCoreInterface.DetailItem] {
        items.map { item in
            return AnalyticsCoreInterface.DetailItem(
                item_id: item.id,
                item_name: item.name,
                item_list_id: itemListId,
                item_list_name: itemListName,
                item_category: item.category,
                item_category2: item.category02,
                item_category3: item.category03,
                item_category4: item.category04,
                item_category5: item.category05
            )
        }
    }
}
