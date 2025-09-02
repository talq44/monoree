import Foundation

public struct ListItem: Codable {
    public let item_id: String
    public let item_name: String
    
    public init(item_id: String, item_name: String) {
        self.item_id = item_id
        self.item_name = item_name
    }
}
