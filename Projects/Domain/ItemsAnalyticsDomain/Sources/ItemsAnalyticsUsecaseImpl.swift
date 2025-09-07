import Foundation
import ItemsAnalyticsDomainInterface
import AnalyticsCoreInterface

final actor ItemsAnalyticsUsecaseImpl: ItemsAnalyticsUsecase {
    private let analytics: AnalyticsManager
    
    init(analytics: AnalyticsManager) {
        self.analytics = analytics
    }
    
    func selectItem(
        listId: String,
        listName: String,
        item: ItemsAnalyticsDomainInterface.ListItem
    ) async {
        let selectItem = SelectItem(
            items: [item.convertAnalytics],
            item_list_id: listId,
            item_list_name: listName
        )
        
        analytics.sendEvent(.select_item(selectItem))
    }
    
    func viewItemList(
        listId: String,
        listName: String,
        items: [ItemsAnalyticsDomainInterface.ListItem]
    ) async {
        let viewItemList = ViewItemList(
            items: items.map { $0.convertAnalytics },
            item_list_id: listId,
            item_list_name: listName
        )
        
        analytics.sendEvent(.view_item_list(viewItemList))
    }
}

extension ItemsAnalyticsDomainInterface.ListItem {
    var convertAnalytics: SimpleItem {
        SimpleItem(item_id: id, item_name: name)
    }
}
