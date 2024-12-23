import AnalyticsCoreInterface

extension AnalyticsEvent {
    var name: String? {
        return String(describing: self)
            .components(separatedBy: "(")
            .first
    }
}
