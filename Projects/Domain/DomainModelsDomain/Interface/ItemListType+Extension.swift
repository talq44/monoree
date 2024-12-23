import Foundation

extension ItemListType {
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
    
    private var info: ItemListInfo? {
        guard let content: ItemListInfo = self.getChildren(self) else {
            return nil
        }
        return content
    }
    
    public var itemListId: String? {
        guard let info else {
            return self.name
        }
        
        guard let id = info.id else {
            return self.name
        }
        
        return self.name + "=" + id
    }
    
    public var itemListName: String? {
        guard let info else {
            return self.name
        }
        
        guard let name = info.name else {
            return self.name
        }
        
        return self.name + "=" + name
    }
}
