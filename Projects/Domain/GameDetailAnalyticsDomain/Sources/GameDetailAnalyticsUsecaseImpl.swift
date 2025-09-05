import Foundation
import FoundationShared
import GameDetailAnalyticsDomainInterface
import AnalyticsCoreInterface

final actor GameDetailAnalyticsUsecaseImpl: GameDetailAnalyticsUsecase {
    private let analytics: AnalyticsManager
    
    init(analytics: AnalyticsManager) {
        self.analytics = analytics
    }
    
    func sendEvent(_ event: GameDetailAnalyticsEvent) async {
        switch event {
        case .add_to_wishlist(let item):
            guard let item = getSendItem(ListItem.self, item: item) else { return }

            analytics.sendEvent(.add_to_wishlist(AddToWishlist(items: [item])))
        case .action(let type):
            analytics.sendEvent(.select_content(SelectContent(
                content_type: type.content_type,
                item_id: type.content_id
            )))
        case .play_item(let item):
            guard let item = getSendItem(DetailItem.self, item: item) else { return }
            
            analytics.sendEvent(.play_item(ViewItem(items: [item])))
        case .view_item(let item):
            guard let item = getSendItem(DetailItem.self, item: item) else { return }
            
            analytics.sendEvent(.view_item(ViewItem(items: [item])))
        }
    }
    
    private func getSendItem<T: Decodable>(
        _ type: T.Type,
        item: Encodable
    ) -> T? {
        guard let data = item.jsonData() else { return nil }
        guard let sendItem = try? JSONDecoder().decode(T.self,from: data) else { return nil }
        
        return sendItem
    }
}
