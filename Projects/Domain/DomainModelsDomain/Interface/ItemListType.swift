import Foundation

public struct ItemListInfo {
    public let id: String?
    public let name: String?
    
    public init(id: String?, name: String?) {
        self.id = id
        self.name = name
    }
}

public enum ItemListType: ItemList {
    case category(ItemListInfo)
    case search(ItemListInfo)
    case wishlist(ItemListInfo)
    case tbd
}
