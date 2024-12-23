import Foundation

public protocol ItemListItem {
    var id: String { get }
    var name: String { get }
    var index: Int { get }
}

public struct ItemListItemImpl: ItemListItem {
    public let id: String
    public let name: String
    public let index: Int
    public init(id: String, name: String, index: Int) {
        self.id = id
        self.name = name
        self.index = index
    }    
}
