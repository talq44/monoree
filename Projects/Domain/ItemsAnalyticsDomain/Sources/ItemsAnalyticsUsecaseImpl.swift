import Foundation
import ItemsAnalyticsDomainInterface
import AnalyticsCoreInterface

final actor ItemsAnalyticsUsecaseImpl: ItemsAnalyticsUsecase {
    private let analytics: AnalyticsManager
    
    init(analytics: AnalyticsManager) {
        self.analytics = analytics
    }
    
    func selectItem(
        item_list_id: String,
        item_list_name: String,
        item: ItemsAnalyticsDomainInterface.ListItem
    ) async {
        let selectItem = SelectItem(
            items: [item.convertAnalytics],
            item_list_id: item_list_id,
            item_list_name: item_list_name
        )
        
        analytics.sendEvent(.select_item(selectItem))
    }
    
    func viewItemList(
        item_list_id: String,
        item_list_name: String,
        items: [ItemsAnalyticsDomainInterface.ListItem]
    ) async {
        let viewItemList = ViewItemList(
            items: items.map { $0.convertAnalytics },
            item_list_id: item_list_id,
            item_list_name: item_list_name
        )
        
        analytics.sendEvent(.view_item_list(viewItemList))
    }
}

extension ItemsAnalyticsDomainInterface.ListItem {
    var convertAnalytics: SimpleItem {
        SimpleItem(item_id: id, item_name: name)
    }
}
