import ProjectDescription

public enum CoreModule: String, CaseIterable {
    case AdMobCore
    case AnalyticsCore
    case LocalDataCore
	case MonoreeDesignSystemCore
	case RemoteConfigCore
    case UserAPICore
    case UserDefaultCore
    
    public var name: String {
        self.rawValue
    }
}
