import ProjectDescription

public enum DomainModule: String, CaseIterable {
	case GameCompletionDomain
    case KoreanChosungDomain
    case VersionCheckDomain
    
    public var name: String {
        self.rawValue
    }
}
