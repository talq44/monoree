import ProjectDescription

public enum CoreModule: String, CaseIterable {
	case AnalyticsCore
	case AuthCore
	case LocalDataCore
    case ImageSearchAPICore
    case RestAPIErrorCore
	case UserAPICore
    
    public var name: String {
        self.rawValue
    }
}
