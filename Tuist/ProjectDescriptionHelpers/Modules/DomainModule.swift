import ProjectDescription

public enum DomainModule: String, CaseIterable {
	case GameListDomain
	case AnimalListDomain
	case ItemsAnalyticsDomain
	case GameDetailAnalyticsDomain
	case UserGameSettingDomain
	case WishlistDomain
	case IDFADomain
	case GameCompletionDomain
    case KoreanChosungDomain
    case VersionCheckDomain
    
    public var name: String {
        self.rawValue
    }
}
