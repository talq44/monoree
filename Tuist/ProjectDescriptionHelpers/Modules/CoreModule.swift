import ProjectDescription

public enum CoreModule: String, CaseIterable {
	case MonoreeDesignSystemCore
	case LocalDataCore
	case RemoteConfigCore
	case AnalyticsCore
	case UserAPICore
    
    public var name: String {
        self.rawValue
    }
}
