import Foundation

public struct HomeDTO: Codable {
    public struct Item: Codable {
        public let id: String
        public let title: String
        public let subTitle: String?
        /// hex
        public let backgroundColor: String?
        public let imageURL: String?
        public let itemCategory: String
        public let itemCategory2: String
    }
    
    public let isShowBanner: Bool
    public let items: [Item]
}
