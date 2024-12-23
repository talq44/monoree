import Foundation

public struct ListItem: Codable {
    public let item_id: String
    public let item_name: String
    public let index: Int?
    
    public init(item_id: String, item_name: String, index: Int?) {
        self.item_id = item_id
        self.item_name = item_name
        self.index = index
    }
}
