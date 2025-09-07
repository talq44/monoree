import Foundation

public protocol ItemsAnalyticsUsecase {
    /// 목록에서 선택할때
    func selectItem(item_list_id: String, item_list_name: String, item: ListItem) async
    /// 목록이 실제 화면에 노출할때
    func viewItemList(item_list_id: String, item_list_name: String, items: [ListItem]) async
}
