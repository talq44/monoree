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
            items: [ListItem(item_id: <#T##String#>, item_name: <#T##String#>)],
            item_list_id: item_list_id,
            item_list_name: item_list_name
        ))
        
        analytics.sendEvent(.select_item(selectItem))
    }
    
    func viewItemList(
        item_list_id: String,
        item_list_name: String,
        items: [ItemsAnalyticsDomainInterface.ListItem]
    ) async {
        
    }
}
