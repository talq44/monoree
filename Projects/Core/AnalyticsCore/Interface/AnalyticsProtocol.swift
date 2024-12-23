import Foundation

public protocol AnalyticsProtocol {
    func add_to_wishlist(_ input: AddToWishlist)
    func login(method: String)
    func screen_view(screen_class: String, screen_name: String)
    func search(search_term: String)
    func select_content(content_type: String, item_id: String)
    func selct_item(_ input: SelectItem)
    func share(content_type: String, item_id: String, method: String)
    func sign_up(method: String)
    func view_item(_ input: ViewItem)
    func view_item_list(_ input: ViewItemList)
    func view_search_results(search_term: String)
}
