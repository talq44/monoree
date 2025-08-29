import ProjectDescription

public enum DomainModule: String, CaseIterable {
	case GameLimitCheckDomain
    case KoreanChosungDomain
    case VersionCheckDomain
    
    public var name: String {
        self.rawValue
    }
}
