import Foundation

public struct GameDetailItem: Sendable, Codable {
    public let item_id: String
    public let item_name: String
    public let item_list_id: String
    public let item_list_name: String
    public let item_category: String
    public let item_category2: String?
    public let item_variant: String
    
    public init(
        item_id: String,
        item_name: String,
        item_list_id: String,
        item_list_name: String,
        item_category: String,
        item_category2: String?,
        item_variant: String
    ) {
        self.item_id = item_id
        self.item_name = item_name
        self.item_list_id = item_list_id
        self.item_list_name = item_list_name
        self.item_category = item_category
        self.item_category2 = item_category2
        self.item_variant = item_variant
    }
}
