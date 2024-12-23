import Foundation

import AnalyticsCoreInterface
import ItemListInteractionDomainInterface

final class ItemListInteractionRepositoryImplementation: ItemListInteractionRepository {
    
    private let analytics: any AnalyticsProtocol
    
    init(analytics: any AnalyticsProtocol) {
        self.analytics = analytics
    }
    
    func sendViewItemList(_ input: any ItemListInteractionInput) {
        let send = ViewItemList(
            items: self.toAnalytics(input.items),
            item_list_id: input.itemList.itemListId,
            item_list_name: input.itemList.itemListName
        )
        self.analytics.sendEvent(.view_item_list(send))
    }
    
    func sendSelectItem(_ input: any ItemListInteractionInput) {
        let send = SelectItem(
            items: self.toAnalytics(input.items),
            item_list_id: input.itemList.itemListId,
            item_list_name: input.itemList.itemListName
        )
        
        self.analytics.sendEvent(.select_item(send))
    }
    
    private func toAnalytics(_ items: [ItemListItem]) -> [ListItem] {
        return items.map { item in
            return ListItem(
                item_id: item.id,
                item_name: item.name,
                index: item.index
            )
        }
    }
}
