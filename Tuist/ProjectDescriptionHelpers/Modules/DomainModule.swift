import ProjectDescription

public enum DomainModule: String, CaseIterable {
	case WishlistDomain
	case IDFADomain
	case GameCompletionDomain
    case KoreanChosungDomain
    case VersionCheckDomain
    
    public var name: String {
        self.rawValue
    }
}
