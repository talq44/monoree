import Foundation

public protocol ItemsAnalyticsUsecase {
    /// 목록에서 선택할때
    func selectItem(listId: String, listName: String, item: ListItem) async
    /// 목록이 실제 화면에 노출할때
    func viewItemList(listId: String, listName: String, items: [ListItem]) async
}
