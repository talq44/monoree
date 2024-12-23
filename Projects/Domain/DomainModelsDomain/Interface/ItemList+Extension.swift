import Foundation

extension ItemList {
    private var name: String {
        return String(describing: self)
            .components(separatedBy: "(")
            .first ?? ""
    }
    
    private func getChildren<T>(_ enumCase: Any) -> T? {
        let mirror = Mirror(reflecting: enumCase)
        for child in mirror.children {
            if let value = child.value as? T {
                return value
            }
        }
        return nil
    }
    
    private var content: ItemListItem? {
        guard let content: ItemListItem = self.getChildren(self) else {
            return nil
        }
        return content
    }
    
    public var itemListId: String? {
        guard let content else {
            return self.name
        }
        return self.name + "=" + content.id
    }
    
    public var itemListName: String? {
        guard let content else {
            return self.name
        }
        return self.name + "=" + content.name
    }
}
