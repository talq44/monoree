import Foundation

public struct HomeDTO: Codable {
    public struct Item: Codable {
        public let id: String
        public let title: String
        public let subTitle: String?
        /// hex
        public let backgroundColor: String?
        public let imageURL: String?
        public let item_category: String
        public let item_category2: String
    }
    
    public let items: [Item]
}
