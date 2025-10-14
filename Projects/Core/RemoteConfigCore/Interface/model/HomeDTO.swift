import Foundation

public struct HomeDTO: Codable {
    public struct Item: Codable {
        public let id: String
        public let title: String
        public let subTitle: String?
        /// hex
        public let backgroundColor: String?
        public let imageURL: String?
        public let itemCategory: String?
        public let itemCategory2: String?
        public let columns: Int
        
        public init(id: String, title: String, subTitle: String?, backgroundColor: String?, imageURL: String?, itemCategory: String?, itemCategory2: String?, columns: Int) {
            self.id = id
            self.title = title
            self.subTitle = subTitle
            self.backgroundColor = backgroundColor
            self.imageURL = imageURL
            self.itemCategory = itemCategory
            self.itemCategory2 = itemCategory2
            self.columns = columns
        }
    }
    
    public let isShowBanner: Bool
    public let items: [Item]
    
    public init(isShowBanner: Bool, items: [Item]) {
        self.isShowBanner = isShowBanner
        self.items = items
    }
}
