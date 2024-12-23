import AnalyticsCoreInterface

extension AnalyticsEvent {
    private func getChildren<T>(_ enumCase: Any) -> T? {
        let mirror = Mirror(reflecting: enumCase)
        for child in mirror.children {
            if let value = child.value as? T {
                return value
            }
        }
        return nil
    }
    
    private var codable: Codable? {
        guard let codable: Codable = self.getChildren(self) else {
            return nil
        }
        return codable
    }
    
    var parameters: [String: Any]? {
        guard let codable = self.codable else { return nil }
        return codable.parameters()
    }
}
