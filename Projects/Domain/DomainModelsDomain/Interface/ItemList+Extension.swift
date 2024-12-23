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
    
    private var content: ItemListInfo? {
        guard let content: ItemListInfo = self.getChildren(self) else {
            return nil
        }
        return content
    }
    
    public var itemListId: String? {
        guard let content else {
            return self.name
        }
        
        guard let id = content.id else {
            return self.name
        }
        
        return self.name + "=" + id
    }
    
    public var itemListName: String? {
        guard let content else {
            return self.name
        }
        
        guard let name = content.name else {
            return self.name
        }
        
        return self.name + "=" + name
    }
}
